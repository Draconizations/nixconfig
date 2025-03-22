{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Jake Fulmine";
    userEmail = "jake@fulmine.xyz";
  };

  programs.ssh.extraConfig = ''
    AddKeysToAgent yes
  '';
}