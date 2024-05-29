#!/bin/bash
    echo "Partitioning with disko and nixos install with impermanence..."
    curl https://raw.githubusercontent.com/xaviduds/.nixos/main/disko.nix -o /tmp/disko.nix
    nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"/dev/nvme0n1"'
    nixos-generate-config --no-filesystems --root /mnt
    mv /tmp/disko.nix /mnt/etc/nixos/
    nix flake init --template github:vimjoyer/impermanent-setup --extra-experimental-features "nix-command flakes"
    curl https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/flake.nix -o /mnt/etc/nixos/flake.nix
    curl https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/configuration.nix -o /mnt/etc/nixos/configuration.nix
    cp -r /mnt/etc/nixos /mnt/persist
    nixos-install --root /mnt --flake /mnt/etc/nixos#default
    sudo rm -rf /etc/nixos/*
    ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub
    while true; do
      read -rp "Have you registered the key (y/n)? " answer
      case $answer in  
        y)
          git clone git@github.com:xaviduds/.nixos.git ~/.nixos
          git clone git@github.com:xaviduds/xaviduds.github.io.git ~/xaviduds.github.io
          git clone git@github.com:xaviduds/.lince_pessoal.git ~/.lince_pessoal
          git clone git@github.com:lince-social/lince.git ~/lince
          break ;;
        *) ;;
      esac
    nix flake update ~/.nixos/ && nixos-rebuild boot --flake ~/.nixos#default--impure && reboot
