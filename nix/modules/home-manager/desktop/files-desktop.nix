{config, ...}: {
  home.file = {
    ".config/kitty/kitty.conf".source = ../../../../config/kitty/kitty.conf;
    ".config/ghostty/config".source = ../../../../config/ghostty/config;
    ".config/alacritty/alacritty.toml".source = ../../../../config/alacritty/alacritty.toml;
    ".config/noctalia/config.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/config/noctalia.toml";
    };
    ".config/niri/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/nix/hosts/desktop/home-manager/niri-desktop-config.kdl";
    };
  };
}
