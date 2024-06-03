#!/bin/bash

while true; do
read -p "[I]nstall | [R]ebuild, [S]SH GitHub config | Repo [C]loning: " -r answer
case $answer in
I)
    # Pull install config files
    sudo curl -L https://raw.githubusercontent.com/xaviduds/.nixos/main/disko.nix -o /tmp/disko.nix
    sudo curl -L https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/flake.nix -o /tmp/flake.nix
    sudo curl -L https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/configuration.nix -o /tmp/configuration.nix

    # Scheme
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"/dev/nvme0n1"'
    sudo nixos-generate-config --no-filesystems --root /mnt

    # mv install config files to it`s place
    sudo mv /tmp/*.nix /mnt/etc/nixos/ && sudo mv /mnt/etc/nixos /mnt/persist

    # Install
    sudo nixos-install --root /mnt --flake /mnt/persist/nixos#default

    # Clone real repo to a persistent dir and reboot
    git clone https://github.com/xaviduds/.nixos.git /mnt/persist/.nixos && reboot
    ;;
R)
    sudo cp -r /persist/.nixos ~/.nixos && mv ~/.nixos/installation/home_second_boot.nix ~/.nixos/home.nix
    sudo nixos-rebuild boot --flake ~/.nixos#default && reboot
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
