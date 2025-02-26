{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      zig-custom = prev.stdenv.mkDerivation {
        pname = "zig";
        version = "0.14.0-dev.3367+1cc388d52";
        src = prev.fetchurl {
          url = "https://ziglang.org/builds/zig-linux-x86_64-0.14.0-dev.3367+1cc388d52.tar.xz";
          sha256 = "sha256-XPzcMwQpnCnz8lZnQsrL8SiXP77nGYhucjq5QW86EaI=";
        };
        sourceRoot = ".";
        installPhase = ''
          mkdir -p $out/bin
          mv zig-linux-x86_64-*/* $out/bin/
        '';
      };
      zls-custom = prev.stdenv.mkDerivation {
        pname = "zls";
        version = "0.14.0-dev.397+30b0da0";
        src = prev.fetchurl {
          url = "https://builds.zigtools.org/zls-linux-x86_64-0.14.0-dev.397+30b0da0.tar.xz";
          sha256 = "sha256-l2Cz6ttxmnCF9OUZsF5Jg5uvcVd9q9/xY2OEJh/RSZQ=";
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

    # mount ntfs drives - "mount.ntfs" command
    ntfs3g
  ];
}
