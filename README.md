<img src="https://github.com/xaviduds/xaviduds/blob/main/desktop.png"></img>
```bash
#Clone at ~/:
git clone git@github.com:xaviduds/nixos.git ~/

# Then update and build NixOS (after that, you can use the 'u' alias):
sudo nix flake update ~/nixos/ && sudo nixos-rebuild switch --flake ~/nixos#default --impure
```
