# :vim:ft=just:

# set enviroment
SYSTEM := `uname -s | tr '[:upper:]' '[:lower:]'`
ARCH := `uname -m`
HOST := `uname -n`
NIX_SYSTEM := SYSTEM + "-" + ARCH
KEEP_AGE := "18d"

# default recipe is to list other recipes
@_default:
  just --list --unsorted

# list system generations
list-generations:
  #!/run/current-system/sw/bin/bash
  set -eufo pipefail
  case {{SYSTEM}} in
    darwin)
      echo "listing nix-darwin generations on {{HOST}}"
      sudo darwin-rebuild --list-generations --flake .#{{HOST}}
      ;;
    linux)
      echo "listing nixos generations on {{HOST}}"
      sudo nixos-rebuild list-generations
      ;;
    *)
      echo "ERROR: I do not know how to list generations for: {{SYSTEM}}"
      ;;
  esac

# rebuild and switch current system
rebuild-switch:
  #!/run/current-system/sw/bin/bash
  set -eufo pipefail
  case {{SYSTEM}} in
    darwin)
      echo "Rebuilding nix-darwin on {{HOST}}"
      sudo darwin-rebuild switch --flake .#{{HOST}}
      ;;
    linux)
      echo "Rebuilding nixos on {{HOST}}"
      sudo nixos-rebuild switch --flake .#{{HOST}}
      ;;
    *)
      echo "ERROR: I do not know how to rebuild: {{SYSTEM}}"
      ;;
  esac

# collect garbage older than 10 days
cleanup-garbage:
  #!/run/current-system/sw/bin/bash
  set -eufo pipefail
  case {{SYSTEM}} in
    linux)
      echo "Clearing old system profiles on {{HOST}}"
      sudo nix profile wipe-history --older-than {{KEEP_AGE}} --profile /nix/var/nix/profiles/system
      ;;
  esac
  echo "Collecting garbage older than {{KEEP_AGE}}"
  nix-collect-garbage --delete-older-than {{KEEP_AGE}}
  sudo nix-collect-garbage --delete-older-than {{KEEP_AGE}}

# update locked system and home-manager dependencies
update-dependencies:
  @nix flake update
