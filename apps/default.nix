{ ... } @ toplevel:
let
  laravel = import ./laravel toplevel;

  apps = {
    inherit (laravel) mkLaravel;
  };
in apps