{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-25-05.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager-25-05 = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixpkgs-25-05,
      home-manager-25-05,
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
    in
    {
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
        mneme = nixpkgs-25-05.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/mneme
            home-manager-25-05.nixosModules.home-manager
            home-manager-options
          ];
        };
      };
    };
}
