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
  configurations.darwin.GraySlab.module =
    { ... }:
    {
      imports = [
        darwin.homebrew
        darwin.fonts
        darwin.nix-store
        darwin.myMacOS
        darwin.user-scott
      ];

      nixpkgs.hostPlatform = "x86_64-darwin";

      home-manager.users = homeManagerUsers;
    };
}
