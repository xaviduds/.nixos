#!/bin/bash

sudo su

while true; do
read -p """
[0] Quit.
[1] Partitioning with disko and nixos install with impermanence.
[2] Configuring after install and reboot

Your answer: """ -r answer

case $answer in  
0) exit 1 ;;

1) read -p """
Swap is 16G, how much of the drive will NixOS take?
[0] Quit.
[1] 250G for /.
[2] 100% for /.

Your answer: """ -r answer

case $answer in  
  0) exit 1 ;;
  1) curl https://raw.githubusercontent.com/xaviduds/.nixos/main/first_install/disko_dual_boot.nix -o /tmp/disko.nix ;;
  2) curl https://raw.githubusercontent.com/xaviduds/.nixos/main/first_install/disko_full_linux.nix -o /tmp/disko.nix ;;
  *) echo "Invalid option selected." ;; esac

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"/dev/nvme0n1"'
sudo nixos-generate-config --no-filesystems --root /mnt
sudo mv /tmp/disko.nix /mnt/etc/nixos/
curl https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/flake.nix -o /mnt/etc/nixos
curl https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/configuration.nix -o /mnt/etc/nixos
sudo cp -r /mnt/etc/nixos /persist
sudo nixos-install --root /mnt --flake /mnt/etc/nixos#default
reboot ;;

2)
sudo rm -rf /etc/nixos/*
ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519

while true; do
cat ~/.ssh/id_ed25519.pub

read -p """
Have you registered the key?
[0] Quit.
[1] Yes.

Your answer: """ -r answer

case $answer in  
  0) exit 1 ;;
  1) git clone git@github.com:xaviduds/.nixos.git ~/.nixos
  git clone git@github.com:xaviduds/xaviduds.github.io.git ~/xaviduds.github.io
  git clone git@github.com:xaviduds/.lince_pessoal.git ~/.lince_pessoal
  git clone git@github.com:lince-social/lince.git ~/lince ;;
  *) echo "Invalid option selected." ;; esac done

sudo nix flake update ~/.nixos/ && sudo nixos-rebuild switch --flake ~/.nixos#default --impure
reboot ;;

*) echo "Invalid option selected." ;; esac done
