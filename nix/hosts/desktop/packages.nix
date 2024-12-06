# home manager packages for desktop
{
  pkgs,
  pkgs-stable,
  ...
}: {
  home.packages = with pkgs; [
    discord
    kitty
    wl-clipboard
    gparted
    steam
    lutris
    wine64
    libresprite
    spotify
    exiftool
    pkgs-stable.obsidian

    xwayland
    vlc
    postgresql_17

    # browsers
    google-chrome
    brave
  ];
}
