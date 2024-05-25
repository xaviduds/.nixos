#!/bin/bash

read -p """
[0] Installation with disko  / = 250G + swap = 16G.
[1] Configuring after installation
""" -r answer

case $answer in  

0)
;;

1)

read -p """
[0] SSH GitHub config
[1] Configuring after installation
""" -r answer

case $answer in  

  ssh-keygen -t ed25519 -C 'xaviduds@gmail.com'
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  cat ~/.ssh/id_ed25519.pub

  git clone git@github.com:xaviduds/.nixos.git ~/.nixos
  git clone git@github.com:xaviduds/xaviduds.github.io.git ~/
  git clone git@github.com:xaviduds/.lincePessoal.git ~/
  git clone git@github.com:lince-social/lince.git ~/
;;

*)
  echo "Invalid option selected."
  exit 1
;;
esac
