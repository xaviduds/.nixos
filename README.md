# My NixOS Setup Process:
For a NixOS explanation, go to something I <a href="https://xaviduds.github.io/src/nixos">wrote</a>.

## Create Bootable USB:
Go to the NixOS <a href="https://nixos.org/download/#nixos-iso">Download</a> page, and select the ISO for the installer you preffer. When the download is finished:
```bash
cat NixOS-iso-name-goes-here.iso > /dev/your-device-name (i.e. 'sda')
```
After that, just boot from the device.

## First boot (from usb):
```bash
# After connecting to the internet, open the terminal and close the GUI installer. Pull install config files:
sudo curl -L https://raw.githubusercontent.com/xaviduds/.nixos/main/disko.nix -o /tmp/disko.nix
sudo curl -L https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/flake.nix -o /tmp/flake.nix
sudo curl -L https://raw.githubusercontent.com/xaviduds/.nixos/main/installation/configuration.nix -o /tmp/configuration.nix

# Scheme:
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"/dev/nvme0n1"'
sudo nixos-generate-config --no-filesystems --root /mnt

# mv install config files to it`s place:
sudo mv /tmp/*.nix /mnt/etc/nixos/ && sudo mv /mnt/etc/nixos /mnt/persist

# Install:
sudo nixos-install --root /mnt --flake /mnt/persist/nixos#default

# Clone real repo to a persistent dir:
sudo git clone https://github.com/xaviduds/.nixos.git /mnt/persist/.nixos

# Temporarily remove unfree packages untill first real build at second boot:
sudo mv /mnt/persist/.nixos/installation/home_second_boot.nix /mnt/persist/.nixos/home.nix && reboot
```
## Second boot:
```bash
# Configure wifi, if not from GUI then:
nmtui

# mv config files to right location:
sudo mv /persist/.nixos ~/

# Sometimes 'nixos-rebuild switch' bugs out on first disk boot, so I first build with 'boot'; hence the three boots;
# Also good to test if Impermanence and Persistance are working correctly:
sudo nixos-rebuild boot --flake ~/.nixos#nixos

# Cleanup wifi info, sometimes it bugs if you maintain wifi files from before persistence, and reboot
sudo rm -rf /persist/system/etc/NetworkManager/system-connections/* && reboot
```
## Third boot:
```bash
# Configure your GitHub SSH Key:
ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub

# Set up GitHub CLI:
gh auth login
```
```bash
# Then, after all the keys have been configured, clone the repos:
git clone git@github.com:xaviduds/.nixos.git ~/.nixos
gh repo clone xaviduds/xaviduds.github.io
gh repo clone xaviduds/.vida
gh repo clone lince-social/lince
```
After that the finishing touches are:
1. Enabling the installed firefox extensions, loggin in GitHub, Whastsapp Web e Gmail.
