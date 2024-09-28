# NixOS

## Configuring a new NixOS machine

- run the basic installation
- clone dotfiles (this repo) into `~/git/`
- create a new host in `./hosts/<new host>`
- copy the following files to `./hosts/<new host>/`
  - `/etc/nixos/configuration.nix`
  - `/etc/nixos/hardware-configuration.nix`
- copy `flake.nix` from one of the existing hosts and modify appropriately
- `sudo nixos-rebuild switch --flake ~/git/dotfiles/nix/hosts/<new host>`

## Configuring a new Nix machine (non NixOS)

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

## Misc

- rebuild with flake
  - `sudo nixos-rebuild switch --flake ~/git/dotfiles/nix/hosts/thinkpad/`
- collect garbage and delete
  `sudo nix-collect-garbage -d`
- build without cache
  `sudo nixos-rebuild switch --flake ~/git/dotfiles/nix/hosts/thinkpad/ --option eval-cache false`
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
