# my commonly used macOS settings
{ ... }:
{
  flake.modules.darwin.myMacOS = { pkgs, ... }: {
    # Packages installed in system profile.
    environment.systemPackages = [
      pkgs.vim
    ];

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
