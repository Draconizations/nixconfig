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
  
  # needed for vscode server to work
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}