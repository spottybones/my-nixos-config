{
  config,
  pkgs,
  ...
}:

let
  nvimPath = "${config.home.homeDirectory}/.config/nix//home-manager/programs/neovim-minimax/nvim-minimax";
in
{
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
      nixfmt-rfc-style
    ];
  };

  xdg.configFile."nvim-minimax".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
}
