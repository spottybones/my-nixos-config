# my zsh configuration
{ ... }:

{
  programs.zsh = {
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
        "eza"
        "vi-mode"
        "z"
      ];
      theme = "agnoster";
      extraConfig = ''
        ZSH_TMUX_AUTOSTART=true

        zstyle :omz:plugins:eza dirs-first yes
        zstyle :omz:plugins:eza show-group yes
        zstyle :omz:plugins:eza icons yes
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

      # set up atuin shell plugin
      eval "$(atuin init zsh)"
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
