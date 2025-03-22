{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Jake Fulmine";
    userEmail = "jake@fulmine.xyz";
  };

  services.ssh-agent.enable = true;
}