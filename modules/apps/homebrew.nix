{ ... }:
{
  flake.modules.darwin.homebrew = { ... }: {
    # set up homebrew
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        # cleanup = "zap";
        upgrade = true;
      };
      taps = [ "nikitabobko/tap" ];
      brews = [ "hugo" ];
      casks = [
        "1password"
        "acorn"
        "bbedit"
        "discord"
        "firefox"
        "google-chrome"
        "google-drive"
        "inkscape"
        "iterm2"
        "kitty"
        "logi-options+"
        "moom"
        "pocket-casts"
        "signal"
        "wezterm"
        "yubico-authenticator"
        "zoom"
      ];
      # masApps = { };
      enableZshIntegration = true;
    };
  };
}
