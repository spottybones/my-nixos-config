{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.wrappers.flakeModules.wrappers ];

  flake.wrappers.neovim = { wlib, ... }: {

    imports = [ wlib.wrapperModules.neovim ];

    settings.config_directory = ./nvim-minimax;

    settings.dont_link = true;
    settings.aliases = [ ];
  };

  flake.modules.homeManager.neovim = {
    imports = [ config.flake.wrappers.neovim.install ];
    wrappers.neovim.enable = lib.mkDefault true;
  };

  # programs.neovim = {
  #   enable = true;
  #   withPython3 = true;
  #   withNodeJs = true;
  #   withRuby = false;
  #
  #   extraPackages = with pkgs; [
  #     bash-language-server
  #     ruff
  #     rust-analyzer
  #     lua51Packages.lua
  #     lua51Packages.luarocks
  #     tree-sitter
  #     nil
  #     nixfmt
  #   ];
  # };
  #
  # xdg.configFile."nvim-minimax".source = ./nvim-minimax;
}
