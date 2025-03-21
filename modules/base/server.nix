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

    networking.networkmanager.enable = true; 
    time.timeZone = "Europe/Amsterdam";

    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}
