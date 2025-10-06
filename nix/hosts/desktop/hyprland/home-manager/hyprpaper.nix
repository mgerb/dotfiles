{...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/wallpaper.jpg"
      ];
      wallpaper = [
        ",~/Pictures/wallpaper.jpg"
      ];
    };
  };
}
