{...}: {
  home.file = {
    ".config/kitty/kitty.conf".source = ../../../../config/kitty/kitty.conf;
    ".config/ghostty/config".source = ../../../../config/ghostty/config;
    ".config/alacritty/alacritty.toml".source = ../../../../config/alacritty/alacritty.toml;
  };
}
