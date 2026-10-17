# nix store management
{ ... }:
{
  flake.modules.darwin.nix-store = { ... }: {
    # enable automatic store optimisation
    nix.optimise = {
      automatic = true;
      interval = [
        {
          Hour = 3;
          Minute = 45;
          Weekday = 7;
        }
      ];
    };

  };

  flake.modules.nixos.nix-store = { ... }: {
    # enable automatic store optimisation
    nix.optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };

  };
}
