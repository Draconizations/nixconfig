{ meta, ... }:

{
  imports = [
    meta.nixModules.wsl
  ];

  fxlmine.machine.type = "wsl";
  fxlmine.machine.usage = "personal";

  system.stateVersion = "24.11";
}