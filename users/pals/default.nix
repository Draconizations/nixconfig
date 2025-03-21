{ lib, ... }:

{
  imports = [
    ./packages.nix
    ./apps.nix
  ];

  home.username = "pals";
  home.homeDirectory = "/home/pals";

  home.stateVersion = lib.mkDefault "24.11";
}