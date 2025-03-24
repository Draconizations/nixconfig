{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];
    
  wsl.enable = true;
  wsl.defaultUser = "pals";

  environment.systemPackages = [ 
    pkgs.nixfmt-rfc-style
  ];
}