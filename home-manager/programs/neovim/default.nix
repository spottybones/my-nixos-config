{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      bash-language-server
      clang
      ruff
      rust-analyzer
      luajit
      luarocks
      tree-sitter
    ];

  };

}
