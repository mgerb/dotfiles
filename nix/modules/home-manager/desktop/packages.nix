{
  pkgs,
  pkgs-stable,
  ...
}: {
  home.packages = with pkgs; [
    kitty
    ghostty
    # alacritty
    discord
    signal-desktop

    # browsers
    # google-chrome
    brave-origin

    steam
    wine64
    spotify
    exiftool
    obsidian
    xwayland
    vlc

    # old sway stuff
    # swaylock-effects
    # wlsunset
    # gammastep
    # wl-gammactl
    # mako # notification system developed by swaywm maintainer
    # grim # screenshot functionality
    # slurp # screenshot functionality
    # wofi
    # polkit
    # wireless network TUI
    # impala # iwd TUI
    # iwd
    # networkmanagerapplet
    # blueman
  ];
}
