#!/bin/bash

mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/zathura
ln -s $HOME/dotfiles/zathura/zathurarc $XDG_CONFIG_HOME/zathura/zathurarc
