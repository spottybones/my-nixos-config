{ config, ... }:
let
  inherit (config.flake.modules) homeManager;
in
{
  flake.modules.homeManager.myDevBox =
    { ... }:
    {
      # import modules for my typical development environment
      imports = [
        homeManager.bat
        homeManager.lazygit
        homeManager.nvim-minimax
        homeManager.tmux
        homeManager.zsh
      ];
    };
}
