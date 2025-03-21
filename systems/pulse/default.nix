{ pkgs, ... }:

{
  system.stateVersion = "24.11";

  # fxlmine.caddy.enable = true;

	services.mysql = {
		enable = true;
		package = pkgs.mariadb;
	};
}