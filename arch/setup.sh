#!/bin/bash

linux_packages=base linux linux-firmware
grub_packages=grub efibootmgr dosfstools os-prober mtools
packages=git neovim vim zsh \
         alsa-utils pulseaudio NetworkManager redshift\
         xorg xorg-server \
         xclip xdotool

pacstrap /mnt $linux_packages $grub_packages $packages
