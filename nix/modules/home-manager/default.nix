{
  user,
  pkgs,
  ...
}: {
  imports = [
    ./files.nix
    ./fonts.nix
    ./mg-scripts.nix
    ./packages.nix
    ./packages-stable.nix
    ./shell-aliases.nix
    ./zsh.nix
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
    GOBIN = "/home/${user}/go/bin";
    PATH = "$GOBIN:$PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.go = {
    enable = true;
    env = {
      GOPATH = "go";
      GOBIN = "go/bin";
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry = {
      package = pkgs.pinentry-curses;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
