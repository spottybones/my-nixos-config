{
  self,
  pkgs,
  ...
}:

{
  # Packages installed in system profile.
  environment.systemPackages = [
    pkgs.vim
  ];

  # set up homebrew
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # cleanup = "zap";
      upgrade = true;
    };
    taps = [ "nikitabobko/tap" ];
    brews = [ ];
    casks = [
      "1password"
      "acorn"
      "aerospace"
      "bbedit"
      "discord"
      "firefox"
      "google-chrome"
      "google-drive"
      "inkscape"
      "iterm2"
      "kitty"
      "logitech-options"
      "moom"
      "signal"
      "wezterm"
      "yubico-authenticator"
    ];
    # masApps = { };
  };

  # Declare user running nix-darwin
  users.users.scott = {
    name = "scott";
    home = "/Users/scott";
  };

  # set scott as primaryUser
  system.primaryUser = "scott";

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.trusted-users = [ "scott" ];

  # enable automatic store optimisation
  nix.optimise = {
    automatic = true;
    interval = [
      {
        Hour = 3;
        Minute = 45;
        Weekday = 7;
      }
    ];
  };

  # Enable zsh support in nix-darwin.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow installation of unfree packages
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # Use TouchID for sudo
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true;
  };

  # install Nerd fonts
  fonts.packages =
    with pkgs.nerd-fonts;
    [
      bitstream-vera-sans-mono
      dejavu-sans-mono
      fira-code
      hack
      inconsolata
      roboto-mono
    ]
    ++ [ pkgs.powerline-symbols ];

  # macOS customizations
  system.defaults.dock = {
    autohide = true;
    magnification = false;
    orientation = "left";
    show-recents = false;
    static-only = true;
  };

}
