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

### Misc

- Wifi
  - nmcli
    - `nmcli dev wifi` to locate the access point(AP) name.
    - `nmcli device wifi connect APname password`
  - `nm-connection-editor`
  - `nmtui`
- bluetooth
  - `blueman-manager`
- audio
  - `pavucontrol`
- files
  - nautilus

### TODO

- thinkpad
  - kvm
  - configure a status bar
    - volume control
