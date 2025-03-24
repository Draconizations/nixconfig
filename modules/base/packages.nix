{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    file
    which
    tmux
    btop
    hyfetch
    fastfetch
    lsof

    wget
    curl
    
    git
    nano
    micro

    python3
  ];
}