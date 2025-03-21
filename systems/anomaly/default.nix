{ meta, ... }:

{
  imports = [
    meta.nixModules.wsl
  ];

  fxlmine.machineType = "wsl";
  fxlmine.machineUsage = "personal";
  fxlmine.docker.enable = true;

  system.stateVersion = "24.11";
}