{ lib, ... }:
with lib;

{
  imports = [
    ./home-manager.nix
    ./nix.nix
    ./packages.nix
    ./docker.nix
    ./users
  ];

  options.fxlmine = {
    machine.type = mkOption {
      type = with types; enum [ "server" "wsl" "laptop" "desktop" ];
      default = "server";
    };

    machine.purpose = mkOption {
      type = with types; enum [ "personal" "server" ];
      default = "server";
    };

    docker.enable = mkEnableOption "Enable docker on this machine" // { default = false; };
  };
}
