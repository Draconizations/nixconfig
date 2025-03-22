{ lib, ... }:
with lib;
{
  networking.networkmanager.enable = mkDefault true;
  services.openssh = {
    enable = mkDefault true;
    settings.PasswordAuthentication = mkDefault false;
  };

  programs.ssh.startAgent = mkDefault true;
  programs.ssh.extraConfig = mkDefault ''
    AddKeysToAgent yes
  '';

  networking.firewall.allowedTCPPorts = mkDefault [ 80 443 ];
}
