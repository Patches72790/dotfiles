#!/bin/bash

# Get machine type
unameOutput="$(uname -s)"
case "${unameOutput}" in
Linux*) machine="linux64" ;;
Darwin*) machine="macos" ;;
*) echo "Unknown machine type. Exiting..." && exit 1 ;;
esac

echo "Machine type ${machine}"
version="stable"
link="https://github.com/neovim/neovim/releases/download/${version}/nvim-${machine}.tar.gz"

mkdir .tmp
cd .tmp

echo "Downloading neovim ${version}..."
wget -q $link

echo "Removing old version of neovim..."
test -e /usr/local/nvim && sudo rm -rf /usr/local/nvim

echo "Extracting tar..."
tar xf nvim-${machine}.tar.gz

echo "Moving executable to /usr/local/nvim/"
sudo mv nvim-${machine} /usr/local/nvim

echo "Cleaning up temp directories..."
cd ..
rm -rf .tmp
echo "Finished updating and installing neovim!"
