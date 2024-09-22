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
    go
    nodejs
    gnumake
    #gcc
    clang
    zig

    # neovim
    neovim
    alejandra
    stylua
    prettierd

    # zsh
    zsh
    oh-my-zsh
    zsh-autosuggestions
  ];
}
