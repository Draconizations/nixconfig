{ lib, config, ... } @ toplevel:
with lib;

let
  cfg = config.fxlmine.immutableUsers;
  knownUsers = import cfg.userDescs toplevel;
  adminGroups =
    [ "wheel" "systemd-journal" ]
    ++ cfg.extraAdminGroups
    ++ lib.optional config.networking.networkmanager.enable "networkmanager"
    ++ lib.optional config.fxlmine.docker.enable "docker" 
    ;

  mkUserDesc = user: desc: {
    inherit (desc) uid hashedPassword;
    isNormalUser = true;
    description = if (desc ? description) then desc.description else null;
    openssh.authorizedKeys.keyFiles = if (desc ? sshKeyFiles) then desc.sshKeyFiles else [];
    extraGroups = mkMerge [
      (mkIf (desc ? isAdmin) adminGroups)
    ];
  };

  mkHomeManager = { user, desc, ... }:
  { meta, ... }: {
    imports =
      (if (desc ? homeManagerPaths)
      then desc.homeManagerPaths
      else [ meta.hmUsers."${user}"]
      );
  };
in
{
  options.fxlmine.immutableUsers = {
    enable = mkEnableOption "immutable user configuration" // { default = true; };
    userDescs = mkOption {
      type = types.path;
      default = ./users.nix;
    };

    extraAdminGroups = mkOption {
      type = with types; listOf str;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    users.mutableUsers = lib.mkForce false;
    users.users = (mapAttrs mkUserDesc knownUsers) // {
      root = {
        initialHashedPassword = "";
          openssh.authorizedKeys.keyFiles =
            (flatten (attrValues (mapAttrs
              (user: desc: if desc.isAdmin then desc.sshKeyFiles else [])
              knownUsers))
            );
      };
    };

    home-manager.users = (mapAttrs
      ( user: desc: mkIf desc.homeManagerEnable (mkHomeManager { inherit user desc; } toplevel))
      knownUsers
    );
  };
}