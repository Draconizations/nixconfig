{ inputs, self, ... }:

with builtins;
with inputs.nixpkgs.lib;

let
  mkNixOS = hostName: system: { extraSpecialArgs ? {} }:
  let
    result = inputs.nixpkgs.lib.nixosSystem {
      system = system;

      specialArgs = extraSpecialArgs // { 
        inherit inputs;
        _passthru = {
          inherit hostName system;
        };

        meta = self;
      };

      modules = [
       "${self}/systems/${hostName}"
        ({ _passthru, ... }: {
          nixpkgs.hostPlatform = _passthru.system;
          networking.hostName = _passthru.hostName;
        })

        self.nixModules.base
      ];
    };
  in
  { "${hostName}" = result; };
in 
{
  flake.nixosConfigurations = mkMerge [
    # WSL
    (mkNixOS "anomaly" "x86_64-linux" {} )

    # Darwin

    # NixOS servers
    (mkNixOS "pulse" "x86_64-linux" {} )
  ];
}