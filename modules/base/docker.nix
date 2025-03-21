{ lib, config, ...}:
with lib;

let
  cfg = config.fxlmine;
in
{
  virtualisation.docker = mkIf cfg.docker.enable {
    enable = true;
    storageDriver = "overlay2";
  };
}