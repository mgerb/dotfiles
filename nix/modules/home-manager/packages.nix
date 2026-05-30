{
  pkgs,
  zigpkgs,
  ...
}: let
  zls-custom = pkgs.stdenv.mkDerivation {
    pname = "zls";
    version = "0.16.0";
    # can also use fetchTarball here and then remove sourceRoot
    src = pkgs.fetchurl {
      url = "https://builds.zigtools.org/zls-x86_64-linux-0.16.0.tar.xz";
      sha256 = "sha256-3tbVYqC4buh4sd33D/qyeXzjzco7AtYHdUj51W3/lrY=";
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
    git
    wget
    jq
    ripgrep
    fd
    tmux
    unzip
    nix-search-cli
    # wireguard-tools
    keyd
    appimage-run
    sqlite
    inetutils
    rsync

    ffmpeg
    yt-dlp

    # software tools
    rustup
    nodejs
    gnumake
    gcc
    libffi

    # python
    python314
    uv
    # python313Packages.cffi
    # python313Packages.pip
    ruff # python formatter
    ty # python lsp
    # pyright

    zigpkgs."0.16.0"
    zls-custom

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
