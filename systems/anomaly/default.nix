{ meta, ... }:

{
  imports = [
    meta.nixModules.wsl
  ];

  fxlmine.machine.type = "wsl";
  fxlmine.machine.purpose = "personal";

  system.stateVersion = "24.11";
}