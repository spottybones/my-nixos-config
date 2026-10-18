{ config, ... }:
let
  inherit (config.flake.modules) nixos homeManager;

  # set home-manager user scott
  homeManagerUsers = {
    scott.imports = [
      homeManager.scott
    ];
  };
in
{
  configurations.nixos.nixie.module =
    { ... }:
    {
      imports = [
        nixos.nix-store
        nixos.myNixOS
        nixos.user-scott
        nixos.nixie-hardware
      ];

      # Define on which hard drive you want to install Grub.
      boot.loader.grub.enable = true;
      boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

      # Enable QEMU Guest Agent
      services.qemuGuest.enable = true;

      # set hostname
      networking.hostName = "nixie"; # Define your hostname.

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = "26.05";

      # set up home-manager users
      home-manager.users = homeManagerUsers;
    };
}
