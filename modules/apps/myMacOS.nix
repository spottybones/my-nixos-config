# my commonly used macOS settings
{ ... }:
{
  flake.modules.darwin.myMacOS =
    {
      pkgs,
      inputs,
      self,
      ...
    }:
    {
      # Packages installed in system profile.
      environment.systemPackages = [
        pkgs.vim
      ];

      # NIX configuration
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      # Allow installation of unfree packages
      nixpkgs.config.allowUnfreePredicate = (pkg: true); # allow unfree packages

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # Enable zsh support in nix-darwin.
      programs.zsh.enable = true;

      # Use TouchID for sudo
      security.pam.services.sudo_local = {
        enable = true;
        touchIdAuth = true;
        reattach = true;
      };

      # macOS customizations
      system.defaults.dock = {
        autohide = true;
        magnification = false;
        orientation = "left";
        show-recents = false;
        static-only = true;
      };
    };
}
