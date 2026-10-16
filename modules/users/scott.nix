{ config, lib, ... }:
let
  myUserName = "scott";
  myFullName = "Scott Burns";
  myEmail = "scott@lentigo.net";
  inherit (config.flake.modules) homeManager;
in
{
  configurations.darwin.Bluish.module = {

    # Declare scott as user running nix-darwin
    users.users.${myUserName} = {
      name = "${myUserName}";
      home = "/Users/${myUserName}";
    };

    system.primaryUser = "${myUserName}";

    nix.settings.trusted-users = [ "${myUserName}" ];
  };

  # inject home-manager user scott into Bluish config
  configurations.darwin.Bluish.module.home-manager.users.${myUserName}.imports = [
    homeManager.${myUserName}
  ];

  configurations.darwin.GraySlab.module = {
    # Declare scott as user running nix-darwin
    users.users.${myUserName} = {
      name = "${myUserName}";
      home = "/Users/${myUserName}";
    };
    system.primaryUser = "${myUserName}";
    nix.settings.trusted-users = [ "${myUserName}" ];
  };

  # inject home-manager user scott into Bluish config
  configurations.darwin.GraySlab.module.home-manager.users.${myUserName}.imports = [
    homeManager.${myUserName}
  ];

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
  };

  # git configuration for Scott
  flake.modules.homeManager.git = { lib, ... }: {
    programs.git.settings.user = {
      name = lib.mkDefault "${myFullName}";
      email = lib.mkDefault "${myEmail}";
    };
  };
}
