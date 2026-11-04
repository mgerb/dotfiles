{pkgs, ...}: {
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["org.kde.dolphin.desktop"];
      "image/jpeg" = ["org.kde.gwenview.desktop"];
      "image/png" = ["org.kde.gwenview.desktop"];
      "image/gif" = ["org.kde.gwenview.desktop"];
      "image/webp" = ["org.kde.gwenview.desktop"];
      "image/bmp" = ["org.kde.gwenview.desktop"];
      "image/tiff" = ["org.kde.gwenview.desktop"];
      "image/svg+xml" = ["org.kde.gwenview.desktop"];
      "image/avif" = ["org.kde.gwenview.desktop"];
    };
  };

  services.udisks2.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities

  # Dolphin
  environment.systemPackages = with pkgs.kdePackages; [
    dolphin
    gwenview # Image viewer
    ark
    kio-extras
    ffmpegthumbs # Video thumbnails in Dolphin
  ];

  # Thunar
  # programs.thunar.enable = true;
  # programs.xfconf.enable = true;
  # programs.thunar.plugins = with pkgs; [
  #   thunar-archive-plugin
  #   thunar-volman
  # ];
  # services.tumbler.enable = true; # Thumbnail support for images
}
