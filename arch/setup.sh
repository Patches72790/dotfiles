#!/bin/bash

linux_packages=base linux linux-firmware
grub_packages=grub efibootmgr dosfstools os-prober mtools
packages=git neovim vim zsh \
         alsa-utils alsa-mixer pulseaudio NetworkManager redshift\
         xorg xorg-server \
         xclip xdotool \
         xfce4-power-manager pavucontrol trayer

pacstrap /mnt $linux_packages $grub_packages $packages
