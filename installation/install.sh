#!/bin/bash

sudo su && nix-shell -p helix

while true; do
clear && lsblk && l

read -p """
[0] Quit.
[1] Partitioning with disko.
[3] SSH GitHub key configuring.
[4] GitHub Repo Cloning.

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
nix flake init --template 
;;

3) ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub ;;

4) git clone git@github.com:xaviduds/.nixos.git ~/.nixos
  git clone git@github.com:xaviduds/xaviduds.github.io.git ~/xaviduds.github.io
  git clone git@github.com:xaviduds/.lince_pessoal.git ~/.lince_pessoal
  git clone git@github.com:lince-social/lince.git ~/lince ;;

*) echo "Invalid option selected." ;; esac done
