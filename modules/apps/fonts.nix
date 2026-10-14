{ ... }:
{
  flake.modules.darwin.fonts = { pkgs, ... }: {
    # install Nerd fonts
    fonts.packages =
      with pkgs.nerd-fonts;
      [
        bitstream-vera-sans-mono
        dejavu-sans-mono
        fira-code
        hack
        inconsolata
        roboto-mono
      ]
      ++ [ pkgs.powerline-symbols ];

  };
}
