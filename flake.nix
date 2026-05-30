{
  description = "Scott Burns' Nix Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-c6d6588.url = "github:NixOS/nixpkgs/c6d65881c5624c9cae5ea6cedef24699b0c0a4c0";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # pre-commit-hooks
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-c6d6588,
      nix-darwin,
      home-manager,
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
    {
      checks = forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            check-added-large-files.enable = true;
            end-of-file-fixer.enable = true;
            # flake-checker.enable = true;
            nixfmt.enable = true;
            trim-trailing-whitespace.enable = true;
          };
        };
      });

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs =
            self.checks.${system}.pre-commit-check.enabledPackages
            ++ (with nixpkgs.legacyPackages.${system}; [
              lua-language-server
              nixd
              nixfmt
              stylua
            ]);
        };
      });

      nixosConfigurations = {
        jupiter = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/jupiter
            home-manager.nixosModules.home-manager
            home-manager-options
          ];
        };
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/nixos
            home-manager.nixosModules.home-manager
            home-manager-options
          ];
        };
        mneme = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/mneme
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
          inherit self;
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
            nixpkgs.overlays = [
              (_final: prev: {
                fish = prev.fish.overrideAttrs (_old: {
                  NIX_FORCE_LOCAL_REBUILD = "darwin-codesign-fix";
                });
              })
              (_final: prev: {
                pkgs-c6d6588 = import nixpkgs-c6d6588 { system = "aarch64-darwin"; };
              })

            ];
          }
        ];
      };
    };
}
