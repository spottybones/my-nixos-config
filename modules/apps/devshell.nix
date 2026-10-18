{ inputs, ... }:
{
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem = { config, pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        lua-language-server
        nixd
        nixfmt
        stylua
        pre-commit
      ];

      shellHook = ''
        ${config.pre-commit.settings.installationScript}
      '';
    };
  };
}
