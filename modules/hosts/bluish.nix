{
  config,
  ...
}:
let
  inherit (config.flake.modules) darwin homeManager;

  # set home-manager user scott
  homeManagerUsers = {
    scott.imports = [
      homeManager.scott
    ];
  };
in
{
  configurations.darwin.Bluish.module =
    { ... }:
    {
      imports = [
        darwin.homebrew
        darwin.fonts
        darwin.nix-store
        darwin.myMacOS
        darwin.user-scott
      ];

      nixpkgs.hostPlatform = "aarch64-darwin";

      home-manager.users = homeManagerUsers;
    };
}
