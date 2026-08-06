{
  description = "Scott Burns' Nix Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # pre-commit-hooks
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      flake-parts,
      ...
    }:

    let
      home-manager-options = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "bak";
          users.scott = import ./home-manager;
        };
      };

      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

    in
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        imports = [
          inputs.git-hooks.flakeModule
          inputs.devshell.flakeModule
        ];
        flake = {

          nixosConfigurations = {
            jupiter = nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = [
                ./hosts/jupiter
                home-manager.nixosModules.home-manager
                home-manager-options
              ];
            };
          };
          darwinConfigurations."GraySlab" = nix-darwin.lib.darwinSystem {
            system = "x86_64-darwin";
            specialArgs = {
              inherit self;
            };
            modules = [
              ./hosts/grayslab
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "bak";
                  users.scott = import ./hosts/grayslab/home.nix;
                };
              }
            ];
          };
          darwinConfigurations."Bluish" = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            specialArgs = {
              inherit inputs self;
            };
            modules = [
              ./hosts/bluish
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  backupFileExtension = "bak";
                  users.scott = import ./hosts/bluish/home.nix;
                };
              }
            ];
          };
        };
        systems = [
          "x86_64-linux"
          "aarch64-darwin"
        ];
        perSystem = { config, pkgs, ... }: {
          # recommend move all package definitions here
          pre-commit = {
            check.enable = true;
            settings = {
              enable = true;
              src = ./.;
              hooks = {
                check-added-large-files.enable = true;
                end-of-file-fixer.enable = true;
                flake-checker = {
                  enable = true;
                  args = [
                    "--condition"
                    "gitRef.contains(\"26.05\")"
                  ];
                };
                nixfmt.enable = true;
                trim-trailing-whitespace.enable = true;
              };
            };
          };

          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              lua-language-server
              nixd
              nixfmt
              stylua
              pre-commit
            ];

            shellHook = ''
              ${config.pre-commit.settings.installationScript}
            '';
          };
        };
      }
    );
}
