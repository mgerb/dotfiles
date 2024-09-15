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
    # TODO: move to desktop only - not required for WSL
    #wl-clipboard
    unzip

    # software tools
    #rustup
    cargo
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
