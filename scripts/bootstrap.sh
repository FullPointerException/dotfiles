#!/bin/bash

bootstrap_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
root_dir=$( dirname ${bootstrap_dir} )

# Copy scripts from bin to ~/.local/bin
bin_dir="${root_dir}/bin"
target_dir="$HOME/.local/bin"
echo "Copying scripts from ${bin_dir} to ${target_dir}"
mkdir -p ${target_dir}
cp ${bin_dir}/* ${target_dir}

# Copy vimrc
vim_dir="${root_dir}/vim"
echo "Copying vim config to ${HOME}"
cp ${vim_dir}/vimrc ${HOME}/.vimrc

# Bash setup
echo "Copying bash config to ${HOME}"
bash_dir="${root_dir}/bash"
cp ${bash_dir}/bash_aliases ${HOME}/.bash_aliases
cp ${bash_dir}/bashrc ${HOME}/.bashrc

# Emacs setup
emacs_dir="${root_dir}/emacs"
target_dir="$HOME/.emacs.d"
echo "Copying emacs config files from ${emacs_dir} to ${target_dir}"
mkdir -p ${target_dir}
mkdir -p ${target_dir}/site-elisp
cp ${emacs_dir}/*.el $HOME/.emacs.d

snippets_dir="${emacs_dir}/snippets"
echo "Copying emacs snippets from ${snippets_dir} to ${target_dir}/snippets"
cp -r ${snippets_dir} ${target_dir}

