{config, ...}: {
  home.file = {
    ".config/niri/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/nix/hosts/thinkpad/home-manager/niri-thinkpad-config.kdl";
    };
  };
}
