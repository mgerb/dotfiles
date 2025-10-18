{
  pkgs,
  pkgs-stable,
  ...
}: {
  home.packages = with pkgs; [
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    kitty
    ghostty
    discord
    signal-desktop

    # browsers
    google-chrome
    brave

    # networking tools
    networkmanagerapplet
    blueman

    steam
    lutris
    wine64
    spotify
    exiftool
    pkgs-stable.obsidian
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
  ];
}
