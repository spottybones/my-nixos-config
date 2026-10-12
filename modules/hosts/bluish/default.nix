{
  withSystem,
  self,
  inputs,
  config,
  ...
}:
let
  inherit (config.flake.modules) homeManager;
in
{
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  };

  flake.darwinConfigurations."Bluish" = withSystem "aarch64-darwin" (
    { pkgs, ... }:
    inputs.nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit self inputs;
      };
      modules = [
        ./_configuration.nix
        # inputs.nixpkgs.nixosModules.readOnlyPkgs
        #use the configured packages from perSystem
        { nixpkgs.pkgs = pkgs; }
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            extraSpecialArgs = { inherit inputs self; };
            users.scott = { ... }: {
              imports = [
                ./_home.nix
                homeManager.myDevBox
                homeManager.wezterm
              ];
            };
          };
        }
      ];
    }
  );
}
