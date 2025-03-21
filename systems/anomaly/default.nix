{ meta, ... }:

{
  imports = [
    meta.nixModules.wsl
  ];

  fxlmine.machineType = "wsl";
  fxlmine.machineUsage = "personal";

  system.stateVersion = "24.11";
}