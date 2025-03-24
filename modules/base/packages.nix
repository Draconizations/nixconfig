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
    
    unzip
    xz

    wget
    curl
    
    git
    nano
    micro

    python3
    gnumake
  ];

  # needed for vscode server to work
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}