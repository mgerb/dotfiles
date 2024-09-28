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
    google-chrome
    spotify
  ];
}
