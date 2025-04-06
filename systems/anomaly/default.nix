{ meta, ... }:

{
  imports = [
    meta.nixModules.wsl
  ];

  fxlmine.machine.type = "wsl";
  fxlmine.machine.purpose = "personal";

  fxlmine.docker.enable = true;

  system.stateVersion = "24.11";
}