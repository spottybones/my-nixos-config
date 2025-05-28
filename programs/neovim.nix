{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = false;
    extraPackages = with pkgs; [
      lua51Packages.lua
      lua51Packages.luarocks
      tree-sitter
    ];
  };
}
