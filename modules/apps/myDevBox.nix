{ config, ... }:
let
  inherit (config.flake.modules) homeManager;
in
{
  flake.modules.homeManager.myDevBox =
    { pkgs, ... }:
    {
      # import modules for my typical development environment
      imports = [
        homeManager.bat
        homeManager.lazygit
        homeManager.nvim-minimax
        homeManager.tmux
        homeManager.zsh
        homeManager.git
      ];

      home.packages = [
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
        pkgs.coreutils
        pkgs.delta
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
        pkgs.google-cloud-sdk
        pkgs.htop
        pkgs.jq
        pkgs.just
        pkgs.lazygit
        pkgs.ncdu
        pkgs.openconnect
        pkgs.pass
        pkgs.ripgrep
        pkgs.sqlite
        pkgs.stow
        pkgs.subnetcalc
        pkgs.tio
        pkgs.wget
        pkgs.xz
        pkgs.uv
      ]
      ++ (with pkgs.python314Packages; [
        python
        pip
      ]);
    };
}
