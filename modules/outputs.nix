{
  lib,
  config,
  inputs,
  self,
  ...
}:
{
  options.configurations.darwin = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
    default = { };
  };

  config.flake.darwinConfigurations = lib.mapAttrs (
    _name: host:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self inputs; };
      modules = [
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        host.module
      ];
    }
  ) config.configurations.darwin;

  #  TODO: still need the following until we refactor all darwinConfigurations
  # define "darwinConfigurations" as a lazyAttrsOf type so multiple
  # declarations can be merged
  options.flake.darwinConfigurations = lib.mkOption {
    default = { };
    type = lib.types.lazyAttrsOf lib.types.raw;
  };

  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
    default = { };
  };

  config.flake.nixosConfigurations = lib.mapAttrs (
    _name: host:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        host.module
      ];
    }
  ) config.configurations.nixos;
}
