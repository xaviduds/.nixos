#!/bin/bash

while true; do

echo "NixOS Install script, what do you want?"
read -p "[I]nstall | [R]ebuild, [S]SH GitHub config | Repo [C]loning: " -r answer

case $answer in
I)
    echo "Partitioning with disko and nixos install with impermanence..."
    sudo curl https://raw.githubusercontent.com/xaviduds/.nixos/main/disko.nix -o /tmp/disko.nix
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"/dev/nvme0n1"'
    sudo nixos-generate-config --no-filesystems --root /mnt
    sudo mv /tmp/disko.nix /mnt/etc/nixos/
    sudo nix flake init --template github:xaviduds/.nixos/installation --extra-experimental-features "nix-command flakes"
    sudo curl https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/flake.nix -o /mnt/etc/nixos/flake.nix
    sudo curl https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/configuration.nix -o /mnt/etc/nixos/configuration.nix
    sudo cp -r /mnt/etc/nixos /mnt/persist
    sudo nixos-install --root /mnt --flake /mnt/etc/nixos#default && reboot
    ;;
R)
    sudo rm -rf /etc/nixos/*
    git clone https://github.com/xaviduds/.nixos.git ~/.nixos
    sudo nix flake --extra-experimental-features "nix-command flakes" update ~/.nixos/ && export NIXPKGS_ALLOW_UNFREE=1 && sudo nixos-rebuild boot --flake ~/.nixos#default --impure
    reboot
    ;;
S)
    ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub
    gh auth login
    ;;
C)
    git clone git@github.com:xaviduds/.nixos.git /home/eduardo/.nixos
    git clone git@github.com:xaviduds/xaviduds.github.io.git /home/eduardo/xaviduds.github.io
    git clone git@github.com:xaviduds/.lince_pessoal.git /home/eduardo/.lince_pessoal
    git clone git@github.com:lince-social/lince.git /home/eduardo/lince
    ;;
esac

done
