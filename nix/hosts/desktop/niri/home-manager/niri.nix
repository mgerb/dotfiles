{
  pkgs,
  config,
  ...
}: {
  home.file = {
    ".config/niri/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/nix/hosts/desktop/niri/config.kdl";
    };
  };
}
