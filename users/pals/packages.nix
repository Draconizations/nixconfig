{ pkgs, fxlmine, ... }:
{
  home.packages =
    with pkgs;
    [
      nnn

      dnsutils
      nmap
      gnupg
    ] ++ (
      if (fxlmine.machineUsage == "personal") then
        [
          nodejs
          bun
          php
        ]
      else
        [ ]
    );
}
