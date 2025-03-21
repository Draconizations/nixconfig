{
  config,
  pkgs,
  lib,
  ...
}:

let
  mkHome = app: {
    home.packages = with pkgs; [
      nodejs_23
      pnpm
      bun
      git
    ];

    home.stateVersion = "24.11";
  };

  mkUser = app: {
    extraGroups = [ ];
    isNormalUser = true;
  };

  mkService =
    app:
    let
      runtime = if (builtins.hasAttr "runtime" app) then app.runtime else "node";
    in
    {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "simple";
        User = "${app.name}";
        ExecStart =
          {
            node = ''${pkgs.nodejs_23}/bin/node /home/${app.name}/${app.path}'';
            bun = ''${pkgs.bun}/bin/bun /home/${app.name}/${app.path}'';
          }
          .${runtime};
        Restart = "on-failure";
        Environment = "PORT=${app.port}";
        WorkingDirectory = lib.mkIf (app ? cwd) "/home/${app.name}/${app.cwd}";
      };
    };

  mkCaddy = app: {
    extraConfig = ''
      			reverse_proxy :${app.port}
      		'';
  };

in
{
  options.fxlmine.nodeApps = lib.mkOption {
    default = [ ];
  };

  config.users.users = builtins.listToAttrs (
    map (app: lib.nameValuePair app.name (mkUser app)) config.fxlmine.nodeApps
  );
  config.home-manager.users = builtins.listToAttrs (
    map (app: lib.nameValuePair app.name (mkHome app)) config.fxlmine.nodeApps
  );
  config.systemd.services = builtins.listToAttrs (
    map (app: lib.nameValuePair app.name (mkService app)) config.fxlmine.nodeApps
  );
  config.services.caddy.virtualHosts = builtins.listToAttrs (
    map (app: lib.nameValuePair app.url (mkCaddy app)) config.fxlmine.nodeApps
  );
}
