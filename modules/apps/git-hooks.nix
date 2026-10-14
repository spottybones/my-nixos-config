{ inputs, ... }:
{
  imports = [
    inputs.git-hooks.flakeModule
  ];

  perSystem = { ... }: {
    # recommend move all package definitions here
    pre-commit = {
      check.enable = true;
      settings = {
        enable = true;
        src = ./.;
        hooks = {
          check-added-large-files.enable = true;
          end-of-file-fixer.enable = true;
          flake-checker = {
            enable = true;
            args = [
              "--condition"
              "gitRef.contains(\"26.05\")"
            ];
          };
          nixfmt.enable = true;
          trim-trailing-whitespace.enable = true;
        };
      };
    };
  };
}
