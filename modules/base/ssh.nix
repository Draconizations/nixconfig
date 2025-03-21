{ config, lib, ... }:
let
  cfg = config.fxlmine.machine;
in
{
  services.openssh = lib.mkIf (cfg.type == "server") {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}