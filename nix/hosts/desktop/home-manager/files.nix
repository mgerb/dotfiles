{config, ...}: {
  home.file = {
    ".config/niri/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/nix/hosts/desktop/home-manager/niri-desktop-config.kdl";
    };
  };
}
