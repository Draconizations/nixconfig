{ lib, ... }:
with lib;

{
  imports = [
    ./home-manager.nix
    ./nix.nix
    ./packages.nix
    ./server.nix
    ./apps
    ./programs
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

    caddy.enable = mkEnableOption "Enable caddy on this machine" // { default = false; };
  };

    time.timeZone = mkDefault "Europe/Amsterdam";
}
