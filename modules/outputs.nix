{ lib, ... }:
{
  # define "darwinConfigurations" as a lazyAttrsOf type so multiple
  # declarations can be merged
  options.flake.darwinConfigurations = lib.mkOption {
    default = { };
    type = lib.types.lazyAttrsOf lib.types.raw;
  };

  # define "homeManagerModules" as a lazyAttrsOf type so multiple
  # declarations can be merged
  options.flake.homeManagerModules = lib.mkOption {
    default = { };
    type = lib.types.lazyAttrsOf lib.types.raw;
  };
}
