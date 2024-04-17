![imagem](https://github.com/xaviduds/nixos/blob/main/img/forReadme/desktopScreenshot0.png)

> ### "This NixOS config has been appointed to you. And if you do not test it, besides me, no one will."
> 
> -- Nixodriel, The Fellowship of the Nix.

```bash
#Clone:
git clone git@github.com:xaviduds/nixos.git ~/

# Then update and build my system (after that, you can use the 'u' alias):
sudo nix flake update ~/nixos/ && sudo nixos-rebuild switch --flake ~/nixos#default --impure
```

