{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      zig-custom = prev.stdenv.mkDerivation {
        pname = "zig";
        version = "0.14.0-dev.3237+ddff1fa4c";
        src = prev.fetchurl {
          url = "https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.3237+ddff1fa4c.tar.xz";
          sha256 = "sha256-B/dQhCt05MWRE6dObaCw8maQDeiziXifKrje1hDbJHA=";
        };
        sourceRoot = ".";
        installPhase = ''
          mkdir -p $out/bin
          mv zig-linux-x86_64-*/* $out/bin/
        '';
      };
      zls-custom = prev.stdenv.mkDerivation {
        pname = "zls";
        version = "0.14.0-dev.390+188a4c0";
        src = prev.fetchurl {
          url = "https://builds.zigtools.org/zls-linux-x86_64-0.14.0-dev.390+188a4c0.tar.xz";
          sha256 = "sha256-1q4WEfSHaIp9q6xtq+jNO0QHN22vE1e1bbH4OYzQlvI=";
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

    # clang

    # python
    python312Full
    python312Packages.cffi
    python312Packages.pip
    black # python formatter
    poetry
    pyright

    zig-custom
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

    # zsh
    zsh
    oh-my-zsh
    zsh-autosuggestions
  ];
}
