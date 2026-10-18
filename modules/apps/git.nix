{ ... }:
{
  flake.modules.homeManager.git = {

    # set up git and github
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings.git_protocol = "ssh";
      settings.editor = "nvim";
    };

    programs.git = {
      enable = true;
      settings.init.defaultBranch = "main";
      settings.pull.rebase = "merges";
    };
  };
}
