{ pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "scott";
  home.homeDirectory = "/home/scott";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    fd
    unzip

    # common programs I use for development
    lazygit
    devenv
    gh
    just
    powerline
    cargo
    clang
    nodejs_20
    uv

    # networking tools
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    #   nix-output-monitor

    # productivity
    htop # replacement of htop/nmon

    # system call monitoring
    lsof # list open files

    # system tools
    pciutils # lspci
    usbutils # lsusb
  ];

  # add ~/.local/bin to last of paths
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Scott Burns";
    userEmail = "scott@lentigo.net";
  };

  # import program configuration
  imports = [
    ./programs/zsh
    ./programs/tmux
    ./programs/neovim
    ./programs/bat
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
