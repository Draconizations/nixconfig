{ pkgs, config, lib, ... }:
with lib; 

let
  caddy = config.fxlmine.caddy;
in
{
  mkNode = name: url: { runtime ? "node", port ? 3000, path ? "app/index.js", cwd ? null }:
    let
    in
    { 
      # app user
      users.users.${name} = {
        isNormalUser = true;
        extraGroups = [];
      };

      # hm user
      home-manager.users.${name} = {
        home.packages = with pkgs; [
          nodejs_23
          bun
          pnpm

        ];

        home.stateVersion = "24.11";
      };

      # systemd service
      systemd.services.${"node-" + name} = {
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
            Type = "simple";
            User = name;
            ExecStart = {
              node = ''${pkgs.nodejs_23}/bin/node /home/${name}/${path}'';
              bun = ''${pkgs.bun}/bin/bun /home/${name}/${path}'';
            }.${runtime};
            Restart="on-failure";
          Environment = "PORT=${app.port}";
          WorkingDirectory = lib.mkIf cwd "/home/${name}/${cwd}";  
        };
      };

      # caddy (if enabled)
      services.caddy.virtualHosts = {
        ${name}.extraConfig = mkIf caddy.enable {
          extraConfig = ''
            reverse_proxy :${port}
          '';
        };
      };
    };
}