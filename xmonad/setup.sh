#!/bin/bash

# dependencies for installing xmonad
sudo pacman -S \
	git xorg-server xorg-apps xorg-xinit xorg-xmessage \
	libx11 libxft libxinerama libxrandr libxss \
	pkgconf

# setup config folder
mkdir -p $XDG_CONFIG_HOME/xmonad && cd $XDG_CONFIG_HOME/xmonad
ln -s $HOME/dotfiles/xmonad/xmonad.hs $XDG_CONFIG_HOME/xmonad/xmonad.hs

# install xmonad repos
git clone git@github.com:xmonad/xmonad.git
git clone git@github.com:xmonad/xmonad-contrib.git

# install ghcup with stack for building
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# start stack project
stack init
stack install

# TODO -- replace last few lines of xinitrc with `exec xmonad` when xorg is setup

# TODO extra packages
# -- xmobar works well with xmonad
