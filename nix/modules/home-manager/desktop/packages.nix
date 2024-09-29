{pkgs, pkgs-stable, ...}: {
  home.packages = with pkgs; [
    # sway stuff
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    kitty
    wofi
    polkit
    swaylock-effects
    wlsunset
    gammastep
    wl-gammactl

    discord

    # networking tools
    networkmanagerapplet
    blueman
    # wireless network TUI
    # impala # iwd TUI
    # iwd
  ];

}
