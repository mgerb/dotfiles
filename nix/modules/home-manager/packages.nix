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
    nix-search-cli
    wireguard-tools

    # software tools
    rustup
    nodejs
    gnumake
    gcc
    libffi

    # clang

    # python
    python312Full
    python312Packages.cffi
    python312Packages.pip
    black # python formatter
    poetry
    pyright

    zig
    zls

    # neovim
    neovim
    lua-language-server
    typescript-language-server
    tailwindcss-language-server
    vscode-langservers-extracted # provides eslint
    angular-language-server
    stylua
    prettierd
    eslint_d
    nil # nix lsp
    alejandra # nix formatter

    # zsh
    zsh
    oh-my-zsh
    zsh-autosuggestions
  ];
}
