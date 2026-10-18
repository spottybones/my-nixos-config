# my commonly used NixOS settings
{ ... }:
{
  flake.modules.nixos.myNixOS =
    {
      pkgs,
      self,
      inputs,
      ...
    }:
    {

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
        neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        which
        zsh
        zstd
      ];

      # NIX configuration
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      # Set trusted users
      nix.settings.trusted-users = [
        "root"
      ];

      # Allow installation of unfree packages
      nixpkgs.config.allowUnfreePredicate = (pkg: true);

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Enable zsh support in nix-darwin.
      programs.zsh.enable = true;
      programs.direnv.enable = true;

      # permit passsordless sudo for "wheel" group
      security.sudo.wheelNeedsPassword = false;

      # Easiest to use and most distros use this by default.
      networking.networkmanager.enable = true;

      # my usual timezome
      time.timeZone = "America/New_York";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

      # Enable the OpenSSH daemon.
      services.openssh = {
        enable = true;
        settings = {
          ClientAliveInterval = "120";
          ClientAliveCountMax = "2";
        };
      };

      # standard environment variables
      environment.variables.EDITOR = "nvim";
    };
}
