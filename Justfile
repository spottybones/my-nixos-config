# :vim:ft=just:

_default:
  @just --list --unsorted

# view the system profile history
view-system-history:
  @nix profile history --profile /nix/var/nix/profiles/system

# remove profiles over seven days old and perform garbage collection
@clear-and-free:
  sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system
  sudo nix-collect-garbage --delete-old
  nix-collect-garbage --delete-old
