![imagem](https://github.com/xaviduds/nixos/blob/main/img/forReadme/desktopScreenshot0.png)

> ### "This NixOS config has been appointed to you. And if you do not test it, besides me, no one will."
> 
> -- Nixodriel, The Fellowship of the Nix.

```bash
# Might bug. Clone the repo at '~/', that's where it looks for when updating and building:
git clone git@github.com:xaviduds/nixos.git ~/

# To build the system for the first time (after that, you can use the 'u' alias), type:
sudo nixos-rebuild switch --flake ~/nixos#default --impure
```

