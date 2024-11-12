#! /bin/bash

echo "Syncing changes from $HOME/.local/bin"
cp "$HOME/.local/bin/jj-git-config-local-repo" ./bin/jj-git-config-local-repo
cp "$HOME/.local/bin/jj-git-delete-tag" ./bin/jj-git-delete-tag

echo "Syncing starship changes"
cp "$HOME/.config/starship/starship.toml" ./starship/starship.toml
