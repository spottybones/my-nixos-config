{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      map-syntax = [
        "Justfile:Just"
        "**/.ssh/config.d/*:SSH Config"
        "uv.lock:TOML"
      ];
      theme = "Enki-Tokyo-Night";
      italic-text = "always";
    };
    extraPackages = with pkgs.bat-extras; [ batman ];
    syntaxes = {
      just = {
        src = pkgs.fetchFromGitHub {
          owner = "nk9";
          repo = "just_sublime";
          rev = "f42cdb012b6033035ee46bfeac1ecd7dca460e55";
          hash = "sha256-VxI5BPrNVOwIRwdZKm8OhTuXCVKOdG8OGKiCne9cwc8=";
        };
        file = "Syntax/Just.sublime-syntax";
      };
    };
    themes = {
      "Enki-Tokyo-Night" = {
        src = pkgs.fetchFromGitHub {
          owner = "enkia";
          repo = "enki-theme";
          rev = "0b629142733a27ba3a6a7d4eac04f81744bc714f";
          hash = "sha256-Q+sac7xBdLhjfCjmlvfQwGS6KUzt+2fu+crG4NdNr4w=";
        };
        file = "scheme/Enki-Tokyo-Night.tmTheme";
      };

      "Catppuccin Mocha" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "699f60fc8ec434574ca7451b444b880430319941";
          hash = "sha256-6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };
}
