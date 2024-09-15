{...}: {
  home.file = {
    ".config/kitty/kitty.conf".source = ../../../../config/kitty/kitty.conf;

    # hyprland
    ".config/hypr/hyprland.conf".source = ../../../../hypr/hyprland.conf;
    ".config/hypr/hyprpaper.conf".source = ../../../../hypr/hyprpaper.conf;
    ".config/hypr/hypridle.conf".source = ../../../../hypr/hypridle.conf;
    ".config/hypr/hyprlock.conf".source = ../../../../hypr/hyprlock.conf;
    ".config/hypr/hyprshade.toml".source = ../../../../hypr/hyprshade.toml;
    ".config/hypr/shaders".source = ../../../../hypr/shaders;
    ".config/waybar/config.jsonc".source = ../../../../config/waybar/config.jsonc;
    ".config/waybar/style.css".source = ../../../../config/waybar/style.css;
  };
}
