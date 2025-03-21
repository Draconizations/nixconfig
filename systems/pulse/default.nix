{ pkgs, ... }:

{
  imports = [
    ./hw.nix
  ];

  fxlmine.machine.type = "server";
  fxlmine.machine.purpose = "server";

  system.stateVersion = "24.11";

  # fxlmine.caddy.enable = true;

	services.mysql = {
		enable = true;
		package = pkgs.mariadb;
	};
}