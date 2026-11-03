{ ... }:
{
  flake.modules.homeManager.jujutsu = { pkgs, ... }: {

    # set up git and github
    programs.jujutsu = {
      enable = true;
      settings = {
        ui = {
          pager = "delta";
          diff-formatter = ":git";
        };
        aliases = {
          l = [
            "log"
            "-r"
            "(main..@):: | main(..@)-"
          ];
        };
      };
    };

    # install lazyjj package
    home.packages = [ pkgs.lazyjj ];
  };
}
