# base packages for all my environments
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    ripgrep
    fd
    tmux
    wl-clipboard
    unzip
    htop
    jq
    rustup
    go
    nodejs
    gnumake
    gcc
    clang
    zig
  ];
}
