# :vim:ft=just:

KEEP_AGE := "18d"

_default:
  @just --list --unsorted

# view the system profile history
@view-system-history:
  nixos-rebuild list-generations

# remove profiles over seven days old and perform garbage collection
clear-and-free:
  sudo nix profile wipe-history --older-than {{KEEP_AGE}} --profile /nix/var/nix/profiles/system
  sudo nix-collect-garbage --delete-older-than {{KEEP_AGE}}
  nix-collect-garbage --delete-older-than {{KEEP_AGE}}
