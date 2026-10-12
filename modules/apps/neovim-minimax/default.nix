{ ... }:
{
  flake.modules.homeManager.nvim-minimax = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;
      withRuby = false;

      extraPackages = with pkgs; [
        bash-language-server
        ruff
        rust-analyzer
        lua51Packages.lua
        lua51Packages.luarocks
        tree-sitter
        nil
        nixfmt
      ];
    };

    xdg.configFile."nvim-minimax".source = ./nvim-minimax;
  };
}
