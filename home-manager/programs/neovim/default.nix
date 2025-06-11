{
  config,
  pkgs,
  ...
}:

let
  nvimPath = "${config.home.homeDirectory}/.config/nix//home-manager/programs/neovim/nvim";
in
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = false;

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

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
}
