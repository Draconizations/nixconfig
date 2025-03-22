{ config, lib, ... }:
let
  cfg = config.fxlmine.machine;
in
{
  config = lib.mkIf (cfg.type == "server") {
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };

  imports = [
    ../../apps/laravel.nix
    ../../apps/node.nix
  ];
}
