{ pkgs, osConfig, ... }:
{
  home.packages =
    with pkgs;
    [
      nnn

      dnsutils
      nmap
      gnupg
    ] ++ (
      if (osConfig.fxlmine.machine.purpose == "personal") then
        [
          nodejs
          bun
          php
          nixd
        ]
      else
        [ ]
    );
}
