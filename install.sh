#! /bin/bash

echo "Setting up $HOME/.local/bin"
mkdir -p $HOME/.local/bin
cp ./bin/* $HOME/.local/bin

echo "Setting up starship"
mkdir -p $HOME/.config/starship
cp ./starship/starship.toml $HOME/.config/starship/starship.toml

