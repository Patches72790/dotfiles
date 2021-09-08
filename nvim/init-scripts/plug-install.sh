#!/bin/bash

PLUG_DIR="$HOME/.local/share/nvim/site/autoload/plug.vim"

if [[ -f "$PLUG_DIR" ]]; then
    echo "Vim Plug already installed"
    exit 1
fi

# Attempt to install Plug.vim into specified directory
curl -fLo "$PLUG_DIR" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ $? -eq 0 ]]; then
    echo "Plug.vim successfully installed in $PLUG_DIR"
else 
    echo "Error occurred."
fi

