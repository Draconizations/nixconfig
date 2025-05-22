{
  config,
  lib,
  pkgs,
  ...
}:
let
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

  # app user
  mkUser = app: {
    isNormalUser = true;
    homeMode = "755";
    extraGroups = [ app.name ];
  };

  # hm user
  mkHome = with pkgs; app: {
    home.packages = [
      php'
      php'.packages.composer

      git
      nodejs_20
    ];

    services.ssh-agent.enable = true;
    home.stateVersion = "24.11";

    systemd.user.services."backup-${app.name}" = if app.backup == true then {
      Service = {
        Type = "oneshot";
        execStart = ''
          cd /home/${app.name}/app
          php artisan backup:run
        '';
      };
      Install.WantedBy = [ "default.target" ];
    } else {};

    systemd.user.timers."backup-${app.name}" = if app.backup == true then {
      Timer = {
        OnCalendar = "daily";
        Persistent = true; 
        Unit = "backup-${app.name}.service";
      };
      Install.WantedBy = [ "timers.target" ];
    } else {};
  };

  # app phpfpm pool
  mkPool = app: {
    user = "${app.name}";
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
        "listen.owner" = config.services.caddy.user;
        "listen.group" = config.services.caddy.group;
      };
  };

  # caddy (if enabled)
  mkCaddy = app: {
    extraConfig = ''
      root * /home/${app.name}/app/public
      encode zstd gzip
      file_server
      php_fastcgi unix/${config.services.phpfpm.pools.${app.name}.socket}
    '';
  };

  forceHome = app: {
    serviceConfig = {
      ProtectHome = lib.mkForce false;
    };
  };
in
{
  options.fxlmine.laravelApps = lib.mkOption {
    default = [ ];
  };

  config.users.groups = builtins.listToAttrs (map (app: lib.nameValuePair app.name {}) config.fxlmine.laravelApps);
  config.users.users = builtins.listToAttrs (
    map (app: lib.nameValuePair app.name (mkUser app)) config.fxlmine.laravelApps
  );
  config.home-manager.users = builtins.listToAttrs (
    map (
      app:
      lib.nameValuePair app.name (mkHome app)
    ) config.fxlmine.laravelApps
  );
  config.services.phpfpm.pools = builtins.listToAttrs (
    map (
      app:
      lib.nameValuePair app.name (mkPool app)
    ) config.fxlmine.laravelApps
  );

  config.systemd.services = if config.fxlmine.caddy.enable then builtins.listToAttrs(
    map (app: lib.nameValuePair ("phpfpm-" + app.name)
      (forceHome app)) config.fxlmine.laravelApps
  ) else {};
  
  config.services.caddy.virtualHosts = if config.fxlmine.caddy.enable then builtins.listToAttrs (
    map (app: lib.nameValuePair app.url (mkCaddy app)) config.fxlmine.laravelApps
  ) else {};
}
