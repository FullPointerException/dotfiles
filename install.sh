#! /bin/bash
set -euo pipefail

SOURCE_BIN_DIR="./bin"
TARGET_BIN_DIR="$HOME/.local/bin"

echo "Setting up ${TARGET_BIN_DIR}"
mkdir -p "${TARGET_BIN_DIR}"
cp "${SOURCE_BIN_DIR}/*" "${TARGET_BIN_DIR}"

echo "Setting up starship"
mkdir -p "$HOME/.config/starship"
cp ./starship/starship.toml "$HOME/.config/starship/starship.toml"

