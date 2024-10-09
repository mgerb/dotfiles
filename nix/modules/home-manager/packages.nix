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
    gcc
    libffi

    # clang

    # python
    python3
    python312Packages.cffi
    python312Packages.pip
    poetry

    zig
    zls

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
