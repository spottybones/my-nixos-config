{ ... }:
{
  flake.modules.homeManager.wezterm =
    { ... }:
    {
      # wezterm configuration
      xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;
    };
}
