#!/bin/bash

# install and switch shell
sudo apt-get install zsh
chsh zsh

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# link zshrc file
ln -s $HOME/dotfiles/zsh/zprofile $HOME/.zprofile
ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
