{
  config,
  ...
}:
let
  inherit (config.flake.modules) darwin;
in
{
  configurations.darwin.Bluish.module =
    {
      inputs,
      self,
      ...
    }:
    {
      imports = [
        darwin.homebrew
        darwin.fonts
        darwin.nix-store
        darwin.myMacOS
        darwin.user-scott
      ];

      # NIX configuration
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

      # Allow installation of unfree packages
      nixpkgs.config.allowUnfreePredicate = (pkg: true); # allow unfree packages
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;
    };
}
