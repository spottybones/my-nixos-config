{
  config,
  ...
}:
let
  inherit (config.flake.modules) nixos;

  # add scott to "docker" group
  dockerGroup = {
    users.scott.extraGroups = [ "docker" ];
  };

in

{
  configurations.nixos.jupiter.module =
    { pkgs, ... }:
    {
      imports = [
        nixos.myNixOS
        nixos.nix-store
        nixos.user-scott
        nixos.jupiter
      ];

      # Use the systemd-boot EFI boot loader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # enable the QEMU guest agent
      services.qemuGuest.enable = true;

      # Define your hostname.
      networking.hostName = "jupiter";

      # host specific system packages
      environment.systemPackages = with pkgs; [
        docker-compose
      ];

      users = dockerGroup;

      # set up Docker virtualisation
      virtualisation.docker = {
        enable = true;
      };

      system.stateVersion = "24.11"; # Did you read the comment?

    };
}
