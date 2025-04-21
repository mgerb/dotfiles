{
  pkgs,
  zigpkgs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      zls-custom = prev.stdenv.mkDerivation {
        pname = "zls";
        version = "0.15.0-dev.60+ea6c0528";
        src = prev.fetchurl {
          url = "https://builds.zigtools.org/zls-linux-x86_64-0.15.0-dev.60+ea6c0528.tar.xz";
          sha256 = "sha256-GkqRvs040mygJz+ErUvTQBBqsP+eeTCPyyHc53XF0bc=";
        };
        sourceRoot = ".";
        installPhase = ''
          mkdir -p $out/bin
          mv zls $out/bin/
        '';
      };
    })
  ];

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
    keyd

    # software tools
    rustup
    nodejs
    gnumake
    gcc
    libffi

    # python
    python312Full
    python312Packages.cffi
    python312Packages.pip
    black # python formatter
    poetry
    pyright

    zigpkgs.master
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

    # zsh
    zsh
    oh-my-zsh
    zsh-autosuggestions

    # mount ntfs drives - "mount.ntfs" command
    ntfs3g
  ];
}
