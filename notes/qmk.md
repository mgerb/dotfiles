# Flashing QMK Keyboard

Udev rules are required to flash the keyboard. Make sure NixOS config has this.

```nix
  environment.systemPackages = with pkgs; [
    via
    qmk
    qmk-udev-rules
  ];
  services.udev.packages = [
    pkgs.via
    pkgs.qmk-udev-rules
  ];
```

```sh
# this will clone and setup the firmware
qmk setup

# search for keyboard
qmk list-keyboards | grep sofl

# set keyboard
qmk config user.keyboard=sofle_choc

# flash the keyboard
qmk flash sofle_choc_sofle_choc_sofle_choc_layout_mine.hex

# press the reset button on the keyboard and it should now load the firmware
```
