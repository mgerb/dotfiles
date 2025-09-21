{
  pkgs,
  zigpkgs,
  ...
}: let
  zls-custom = pkgs.stdenv.mkDerivation {
    pname = "zls";
    version = "0.15.0";
    # can also use fetchTarball here and then remove sourceRoot
    src = pkgs.fetchurl {
      url = "https://builds.zigtools.org/zls-x86_64-linux-0.15.0.tar.xz";
      sha256 = "sha256-UIv+P9Y30qAvB/P8faiQA1H0BxFrA2hcXa4mtPAaMN4=";
    };
    # This will extract the tarball and set the root path
    sourceRoot = ".";
    installPhase = ''
      mkdir -p $out/bin
      mv zls $out/bin/
    '';
  };
in {
  home.packages = with pkgs; [
    vim
    killall
    git
    jujutsu
    wget
    jq
    ripgrep
    fd
    tmux
    unzip
    nix-search-cli
    wireguard-tools
    keyd

    # software tools
    rustup
    nodejs
    gnumake
    gcc
    libffi

    # python
    python312
    python312Packages.cffi
    python312Packages.pip
    black # python formatter
    poetry
    pyright

    zigpkgs."0.15.1"
    zls-custom

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
    tree-sitter
    neovim-remote

    # zsh
    zsh
    oh-my-zsh
    zsh-autosuggestions

    # mount ntfs drives - "mount.ntfs" command
    ntfs3g
  ];
}
