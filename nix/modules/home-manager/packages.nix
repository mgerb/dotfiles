{pkgs, ...}: {
  home.packages = with pkgs; [
    vim
    killall
    git
    wget
    htop
    jq
    ripgrep
    fd
    tmux
    unzip

    # software tools
    rustup
    nodejs
    gnumake
    #gcc
    clang
    zig

    # neovim
    neovim
    lua-language-server
    stylua
    prettierd
    nil # nix lsp
    alejandra # nix formatter

    # zsh
    zsh
    oh-my-zsh
    zsh-autosuggestions
  ];
}
