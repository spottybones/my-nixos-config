{
  config,
  ...
}:
let
  inherit (config.flake.modules) homeManager darwin generic;
  myUser = "scott";
  myHomeDir = "/Users/scott";
in
{
  configurations.darwin.Bluish.module =
    {
      inputs,
      self,
      lib,
      ...
    }:
    {
      imports = [
        darwin.homebrew
        darwin.fonts
        generic.nix-store
        darwin.myMacOS
      ];

      # NIX configuration
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.trusted-users = [ "${myUser}" ];
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      # Allow installation of unfree packages
      nixpkgs.config.allowUnfreePredicate = (pkg: true); # allow unfree packages
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Declare scott as user running nix-darwin
      users.users.${myUser} = {
        name = "${myUser}";
        home = "${myHomeDir}";
      };

      system.primaryUser = "${myUser}";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # home-manager aspects for primaryUser
      home-manager.users.${myUser} = {
        imports = [
          homeManager.myDevBox
          homeManager.wezterm
        ];

        home = {
          username = "${myUser}";
          # lib.mkForce apparently required when using a home-manager module install with nix-darwin
          homeDirectory = lib.mkForce "${myHomeDir}";
          stateVersion = "24.11"; # Please read the comment before changing.

          sessionVariables = {
            EDITOR = "nvim";
            NVIM_APPNAME = "nvim-minimax";
          };

          # add ~/.local/bin to last of paths
          sessionPath = [
            "${myHomeDir}/.local/bin"
          ];
        };

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;

        # enable XDG directory support
        xdg.enable = true;
      };
    };
}
