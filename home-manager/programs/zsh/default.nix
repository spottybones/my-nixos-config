# my zsh configuration
{ pkgs, lib, ... }:

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
        "git"
        "tmux"
        "vi-mode"
        "z"
      ];
      theme = "agnoster";
      extraConfig = lib.mkDefault ''
        ZSH_TMUX_AUTOSTART=false
      '';
    };

    defaultKeymap = "viins";

    shellAliases = {
      l = "ls";
    };

    initContent = ''
      # # The git plugin, if enabled, aliases "gam" to "git am". If the plugin/alias is
      # # enabled, disable it to prevent conflict with Google Admin Manager "gam".
      [[ -n $(alias gam) ]] && unalias gam
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--group"
    ];
  };
}
