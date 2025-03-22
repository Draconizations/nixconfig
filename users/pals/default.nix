{ lib, ... }:

{
  imports = [
    ./packages.nix
    ./programs.nix
  ];

  home.username = "pals";
  home.homeDirectory = "/home/pals";

  home.stateVersion = lib.mkDefault "24.11";
}