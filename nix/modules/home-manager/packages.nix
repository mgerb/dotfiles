{
  pkgs,
  zigpkgs,
  ...
}: let
  zls-custom = pkgs.stdenv.mkDerivation {
    pname = "zls";
    version = "0.17.0-dev.44+8da87d4f";
    src = pkgs.fetchurl {
      url = "https://builds.zigtools.org/zls-x86_64-linux-0.17.0-dev.44+8da87d4f.tar.xz";
      sha256 = "sha256-nqIj+ohCRnFVWRG+ul1okZGuCApOgn71x2yPZOOf8pY=";
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
    hydra-check # check build status of nixos channels
    wl-clipboard

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

    zigpkgs.master
    zls-custom
    zig-zlint

    # Neovim
    neovim
    lua-language-server
    typescript-language-server
    tailwindcss-language-server
    vscode-css-languageserver
    vscode-json-languageserver
    angular-language-server
    stylua
    prettierd
    eslint
    eslint_d
    nil # nix lsp
    alejandra # nix formatter
    tree-sitter
    neovim-remote # nvr

    # zsh
    zsh
    oh-my-zsh
    zsh-autosuggestions

    # mount ntfs drives - "mount.ntfs" command
    ntfs3g
  ];
}
