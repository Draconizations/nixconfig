{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.fxlmine.caddy;
in
{
	services.caddy = mkIf cfg.enable {
		enable = true;
		package = pkgs.caddy;
	};

	systemd.services.caddy.serviceConfig = mkIf cfg.enable {
		ProtectHome = lib.mkForce false;
	};
}
