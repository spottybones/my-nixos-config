# :vim:ft=just:

_default:
  @just --list --unsorted

view-system-history:
  @nix profile history --profile /nix/var/nix/profiles/system
