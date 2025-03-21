{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  system.stateVersion = "24.11";
  wsl.enable = true;
  wsl.defaultUser = "pals";

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}