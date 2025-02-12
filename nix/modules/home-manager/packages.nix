{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      zig-custom = prev.stdenv.mkDerivation {
        pname = "zig";
        version = "0.14.0-dev.3197";
        src = prev.fetchurl {
          url = "https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.3197+1d8857bbe.tar.xz";
          sha256 = "sha256-o72foPkVmulUVc2iUpynV1wzI/+2h/So1c48lZQXIxQ=";
        };
        sourceRoot = ".";
        installPhase = ''
          mkdir -p $out/bin
          mv zig-linux-x86_64-*/* $out/bin/
        '';
      };
      zls-custom = prev.stdenv.mkDerivation {
        pname = "zls";
        version = "0.14.0-dev.383";
        src = prev.fetchurl {
          url = "https://builds.zigtools.org/zls-linux-x86_64-0.14.0-dev.383+f06cee3.tar.xz";
          sha256 = "sha256-fj2xIR5GWVQlJiEwJVrFeXMyyctuYOXr8N5Q33nHORc=";
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
