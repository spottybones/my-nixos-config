# my zsh configuration
{ pkgs, ... }:

{
  programs.zsh = {
    package = pkgs.zsh;
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 20000;
      save = 20000;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "direnv"
        "git"
        "tmux"
        "eza"
        "vi-mode"
        "fzf"
        "z"
      ];
      theme = "agnoster";
      extraConfig = ''
        ZSH_TMUX_AUTOSTART=false

        zstyle :omz:plugins:eza dirs-first yes
        zstyle :omz:plugins:eza show-group yes
        zstyle :omz:plugins:eza icons yes
      '';
    };

    defaultKeymap = "viins";

    shellAliases = {
      l = "ls";
    };

  };
}
