{ inputs, ... }:
{
  flake.modules.homeManager.jujutsu = { pkgs, ... }: {

    home.packages = [
      inputs.jujutsu.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.lazyjj
    ];
  };
}
