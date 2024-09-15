# NixOS

## Issues

- collect garbage and delete
  `sudo nix-collect-garbage -d`
- build without cache
  `sudo nixos-rebuild switch --flake ./thinkpad --option eval-cache false`
- clean store
  - `nix store verify --all --no-trust`

## Updating

```sh
sudo nix-channel --update

# cd into host config
cd thinkpad
sudo nix flake update
sudo nixos-rebuild switch --upgrade --flake .
```

## Thinkpad

`sudo nixos-rebuild switch --flake ./thinkpad`

## Home Server

`sudo nixos-rebuild switch --flake ./home-server`

## Nix as a package manager (without NixOS)

See `./hosts/ubuntu/flake.nix` for example.

- first install [nix package manager](https://nixos.org/download)
- install home mananger
  ```sh
  nix run home-manager/master -- init --switch
  ```
  - this will install with a basic flake, then run the next rebuild command
- rebuild
  ```sh
  home-manager switch --flake ./nix/hosts/ubuntu
  ```
- NOTE: must manually set zsh as default shell
  ```sh
  which zsh >> /etc/shells
  chsh -s $(which zsh)
  ```

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
