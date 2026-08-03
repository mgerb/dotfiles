{config, ...}: {
  home.file = {
    ".config/niri/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/nix/hosts/desktop/home-manager/niri-desktop-config.kdl";
    };

    ".config/hypr/hyprland.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/nix/hosts/desktop/home-manager/hyprland-desktop.lua";
    };
  };
}
