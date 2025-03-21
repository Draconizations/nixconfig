{
  pkgs,
  config,
  lib,
  ...
}:
with lib;

let
  caddy = config.fxlmine.caddy;

  php' = pkgs.php.buildEnv {
    extensions =
      { enabled, all }:
      with all;
      enabled
      ++ [
        memcached
      ];
    extraConfig = ''
      memory_limit = 512M
    '';
  };
in
{
  mkLaravel =
    name: url:
    let
    in
    {
      # app user
      users.users.${name} = {
        isNormalUser = true;
        homeMode = 755;
        extraGroups = [ ];
      };

      # hm user
      home-manager.users.${name} = {
        home.packages = with pkgs; [
          php'
          php'.packages.composer

          git
          nodejs_20
        ];

        home.stateVersion = "24.11";
      };

      # app phpfpm pool
      services.phpfpm.pools.${name} = {
        user = name;
        phpPackage = php';
        settings =
          {
            "pm" = "dynamic";
            "pm.max_children" = 32;
            "pm.max_requests" = 500;
            "pm.start_servers" = 2;
            "pm.min_spare_servers" = 2;
            "pm.max_spare_servers" = 5;
            "php_admin_value[error_log]" = "stderr";
            "php_admin_flag[log_errors]" = true;
            "catch_workers_output" = true;
          }
          ++ mkIf caddy.enable {
            "listen.owner" = config.services.caddy.user;
            "listen.group" = config.services.caddy.group;
          };
      };

      # caddy (if enabled)
      services.caddy.virtualHosts = {
        ${name}.extraConfig = mkIf caddy.enable {
          extraConfig = ''
            root * /home/${name}/app/public
            encode zstd gzip
            file_server
            php_fastcgi unix/${config.services.phpfpm.pools.${name}.socket}
          '';
        };
      };
    };
}
