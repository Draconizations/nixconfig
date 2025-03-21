{ lib, ... }:
with lib;

{
  imports = [
    ./home-manager.nix
    ./nix.nix
    ./packages.nix
    ./users
  ];

  options.fxlmine = {
    machineType = mkOption {
      type = with types; enum [ "server" "wsl" "laptop" "desktop" ];
      default = "server";
    };

    machineUsage = mkOption {
      type = with types; enum [ "personal" "server" ];
      default = "server";
    };

    docker.enable = mkEnableOption "Enable docker on this machine" // { default = false; };
  };
}
