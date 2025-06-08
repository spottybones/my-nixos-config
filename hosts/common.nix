{ pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # packages I expect to use on all systems
  environment.systemPackages = with pkgs; [
    bat
    file
    gawk
    git
    gnupg
    gnused
    gnutar
    tree
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    which
    zsh
    zstd
  ];

  # standard environment variables
  environment.variables.EDITOR = "vim";

  programs.direnv.enable = true;
  programs.zsh.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      ClientAliveInterval = "120";
      ClientAliveCountMax = "2";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  networking.enableIPv6 = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set trusted users
  nix.settings.trusted-users = [
    "root"
    "scott"
  ];
}
