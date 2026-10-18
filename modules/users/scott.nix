{ config, ... }:
let
  myUserName = "scott";
  myFullName = "Scott Burns";
  myEmail = "scott@lentigo.net";

  inherit (config.flake.modules) homeManager;

  # darwin user "scott"
  flake.modules.darwin."user-${myUserName}" = {
    users.users.${myUserName} = {
      name = "${myUserName}";
      description = "${myFullName}";
      home = "/Users/${myUserName}";
    };

    system.primaryUser = "${myUserName}";

    nix.settings.trusted-users = [ "${myUserName}" ];
  };

  # nixos user "scott"
  flake.modules.nixos."user-${myUserName}" = { pkgs, ... }: {
    users.users.${myUserName} = {
      name = "${myUserName}";
      description = "${myFullName}";
      home = "/home/${myUserName}";

      isNormalUser = true;
      # Enable 'docker' control for the user
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user
        "networkmanager" # Enable ‘sudo’ for the user
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDd4nbpzqHdNWJCNDGg5NbZ1zX9OHwJIr9//mjtDL9mv"
      ];
      shell = pkgs.zsh;
    };

    # Set trusted users
    nix.settings.trusted-users = [
      "scott"
    ];
  };

  # home manager for Scott
  flake.modules.homeManager.${myUserName} = { pkgs, lib, ... }: {

    imports = [
      homeManager.myDevBox
      homeManager.wezterm
    ];

    home = {
      username = "${myUserName}";
      homeDirectory = lib.mkDefault (
        if pkgs.stdenvNoCC.isDarwin then "/Users/${myUserName}" else "/home/${myUserName}"
      );
      stateVersion = "24.11"; # Please read the comment before changing.

      sessionVariables = {
        EDITOR = "nvim";
        NVIM_APPNAME = "nvim-minimax";
      };

      # add ~/.local/bin to last of paths
      sessionPath = [
        (
          if pkgs.stdenvNoCC.isDarwin then
            "/Users/${myUserName}/.local/bin"
          else
            "/home/${myUserName}/.local/bin"
        )
      ];
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # enable XDG directory support
    xdg.enable = true;

    # # git configuration for Scott
    # flake.modules.homeManager.git = { lib, ... }: {
    programs.git.settings.user = {
      name = lib.mkDefault "${myFullName}";
      email = lib.mkDefault "${myEmail}";
    };
    # };
  };
in
{
  inherit flake;
}
