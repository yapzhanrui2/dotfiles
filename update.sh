#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
cd "$DIR"

echo "Updating Nix flake inputs..."
nix flake update

echo "Rebuilding nix-darwin and Home Manager..."
sudo /run/current-system/sw/bin/darwin-rebuild \
  switch \
  --flake "$DIR#mac"

echo "Updating Homebrew..."
brew update
brew upgrade
brew cleanup

echo
echo "Update complete."
echo "Review the lock-file changes with:"
echo "  git diff flake.lock"
