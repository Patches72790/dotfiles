#!/bin/bash

# Add release PGP keys
sudo curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

# Add stable channel to apt sources
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

# add candidate channel to sources
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing candidate" | sudo tee /etc/apt/sources.list.d/syncthing.list

# increase preference of syncthing packages
printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing

sudo apt-get update
sudo apt-get install syncthing


# TODO -- need to also setup systemctl service for installing

#[Unit]
#Description=Syncthing - Open Source Continuous File Synchronization
#Documentation=man:syncthing(1)
#After=network.target
#
#[Service]
#User=pi
#ExecStart=/usr/bin/syncthing -no-browser -no-restart -logflags=0
#Restart=on-failure
#RestartSec=5
#SuccessExitStatus=3 4
#RestartForceExitStatus=3 4
#
## Hardening
#ProtectSystem=full
#PrivateTmp=true
#SystemCallArchitectures=native
#MemoryDenyWriteExecute=true
#NoNewPrivileges=true
#
#[Install]
#WantedBy=multi-user.target
