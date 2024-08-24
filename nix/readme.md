# NixOS

- collect garbage and delete
  `sudo nix-collect-garbage -d`
- build without cache
  `sudo nixos-rebuild switch --flake ./thinkpad --option eval-cache false`

## Updating

```sh
sudo nix-channel --update

# cd into host config
cd thinkpad
sudo nix flake update
sudo nixos-rebuild switch . --upgrade
```

## Thinkpad

`sudo nixos-rebuild switch --flake ./thinkpad`

## Home Server

`sudo nixos-rebuild switch --flake ./home-server`

### TODO

- thinkpad
  - kvm
  - configure a status bar
    - volume control
