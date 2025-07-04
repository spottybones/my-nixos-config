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

  # Declare user running nix-darwin
  users.users.scott = {
    name = "scott";
    home = "/Users/scott";
  };

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
  nixpkgs.hostPlatform = "x86_64-darwin";

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
      hack
      inconsolata
      roboto-mono
    ]
    ++ [ pkgs.powerline-symbols ];

}
