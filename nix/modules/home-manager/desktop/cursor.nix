{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;

    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 24;
  };
}
