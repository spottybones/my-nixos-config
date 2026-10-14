# nix store management
{ ... }:
{
  flake.modules.generic.nix-store = { ... }: {
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
}
