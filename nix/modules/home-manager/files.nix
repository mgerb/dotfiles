{config, ...}: {
  home.file = {
    ".config/nvim" = {
      # this must be a symlink because neovim makes file modifications at runtime
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/config/nvim";
    };

    ".tmux.conf".source = ../../../.tmux.conf;
  };
}
