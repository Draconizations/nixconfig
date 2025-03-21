{ inputs, config, ... } @ toplevel:
let
  fxlmine = config.fxlmine;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit (toplevel) inputs meta _passthru;
      inherit fxlmine;
    };
  };
}