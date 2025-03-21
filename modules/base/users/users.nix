{ meta, ...}:

let
  sshKeys = user: [
    "${meta}/users/${user}/authorized_keys"
  ];
in
{
  pals = {
    uid = 1000;
    isAdmin = true;
    description = "Pals";
    sshKeyFiles = sshKeys "pals";
    hashedPassword = "$y$j9T$Rudg47EKrRDl9wKlDqZK20$v8Jb5P5odDJhCbyBQUZwXZ6poMPh7UGoH/Mt9GEFMW5";

    homeManagerEnable = true;
  };
}