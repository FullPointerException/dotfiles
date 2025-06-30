#! /bin/bash
set -euo pipefail

SOURCE_BIN_DIR="$HOME/.local/bin"
TARGET_BIN_DIR="./bin"

echo "Syncing changes from ${SOURCE_BIN_DIR}"
cp "${SOURCE_BIN_DIR}/jj-git-config-local-repo" "${TARGET_BIN_DIR}/jj-git-config-local-repo"
cp "${SOURCE_BIN_DIR}/jj-git-delete-tag" "${TARGET_BIN_DIR}/jj-git-delete-tag"

echo "Syncing starship changes"
cp "$HOME/.config/starship/starship.toml" ./starship/starship.toml
