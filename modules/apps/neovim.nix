{ inputs, lib, ... }:
{
  flake.modules.homeManager.neovim = { pkgs, ... }: {

    home.packages = [
      inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
