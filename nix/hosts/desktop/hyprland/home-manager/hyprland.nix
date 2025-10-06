{config, ...}: {
  home.file = {
    ".config/hypr/hyprland.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/nix/hosts/desktop/hyprland/hyprland.conf";
    };
  };

  services.hyprpolkitagent.enable = true;
}
