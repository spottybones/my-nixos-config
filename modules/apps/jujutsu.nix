{ ... }:
{
  flake.modules.homeManager.jujutsu = { pkgs, ... }: {

    # set up git and github
    programs.jujutsu = {
      enable = true;
      settings = {
        ui = {
          diff-formatter = ":git";
        };
      };
    };

    programs.delta.enableJujutsuIntegration = true;

    # install lazyjj package
    home.packages = [ pkgs.lazyjj ];
  };
}
