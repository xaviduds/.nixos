Clone the repo at '~/', that's where it looks for when updating and building through the 'u' shortcut; be careful to not overwrite an existing nixos directory:

```bash
git clone git@github.com:xaviduds/nixos.git ~/
```

To build the system for the first time:
```bash
sudo nixos-rebuild switch --flake ~/nixos#default --impure
```

After that, just type:
```bash
u
```

> "This NixOS config has been revealed to you. And if you do not test it, besides me, no one will"
> -- Nixodriel, The Felloship of the Nix.
