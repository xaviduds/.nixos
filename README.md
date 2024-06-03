First boot - Install:
```bash
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
sudo git clone https://github.com/xaviduds/.nixos.git /mnt/persist/.nixos && sudo mv /mnt/persist/.nixos/installation/home_second_boot.nix /mnt/persist/.nixos/home.nix && reboot
```
Second boot - Prepare and build system:
```bash
sudo cp -r /persist/.nixos ~/.nixos && sudo nixos-rebuild boot --flake ~/.nixos#default && reboot
```
Third boot - Configure GitHub repo access, then clone repos:
```bash
ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub
gh auth login
```
```bash
gh repo clone xaviduds/.nixos ~/
gh repo clone xaviduds/xaviduds.github.io ~/
gh repo clone xaviduds/.lince_pessoal ~/
gh repo clone lince-social/lince ~/
```
