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
  ];
}
