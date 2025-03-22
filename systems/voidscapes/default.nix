{ pkgs, ... }:

{
  imports = [
    ./hw.nix
    ./apps.nix
  ];

  fxlmine.machine.type = "server";
  fxlmine.machine.purpose = "server";
  fxlmine.caddy.enable = true;

  system.stateVersion = "24.11";

  # fxlmine.caddy.enable = true;

	services.mysql = {
		enable = true;
		package = pkgs.mariadb;
	};
}