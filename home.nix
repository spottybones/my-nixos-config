{ pkgs, lib, ... }:

{
  # import package configurations
  imports = [
    ./home-manager/programs/tmux
    ./home-manager/programs/zsh
    ./home-manager/programs/neovim
    ./home-manager/programs/bat
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "scott";

  # lib.mkForce apparently required when using a home-manager module install with nix-darwin
  home.homeDirectory = lib.mkForce "/Users/scott";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      pkgs._1password-cli
      pkgs.atuin
      pkgs.bat
      pkgs.cargo
      pkgs.coreutils
      pkgs.delta
      pkgs.devenv
      pkgs.direnv
      pkgs.eza
      pkgs.fd
      pkgs.findutils
      pkgs.fzf
      pkgs.gawk
      pkgs.gh
      pkgs.git
      pkgs.git-crypt
      pkgs.gnupg
      pkgs.gnused
      pkgs.go
      pkgs.google-cloud-sdk
      pkgs.htop
      pkgs.jq
      pkgs.julia-bin
      pkgs.just
      pkgs.lazygit
      pkgs.ncdu
      pkgs.openconnect
      pkgs.pass
      pkgs.powerline
      pkgs.ripgrep
      pkgs.sqlite
      pkgs.stow
      pkgs.subnetcalc
      pkgs.tio
      pkgs.wget
      pkgs.xz
      pkgs.uv
    ]
    ++ (with pkgs.python313Packages; [
      python
      pip
    ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/scott/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # enable XDG directory support
  xdg.enable = true;

  # override TMUX AUTOSTART for Grayslab
  programs.zsh.oh-my-zsh.extraConfig = lib.mkForce ''
    ZSH_TMUX_AUTOSTART=true
  '';
}
