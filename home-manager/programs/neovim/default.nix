{ pkgs, ... }:

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
      lua51Packages.lua
      lua51Packages.luarocks
      tree-sitter
      nil
      nixfmt-rfc-style
    ];

  };

}
