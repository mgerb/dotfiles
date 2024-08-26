# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  wsl.defaultUser = "nixos";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    wget
    vim
    neovim
    ripgrep
    fd
    rustc
    cargo
    tmux
    starship
    zsh
    oh-my-zsh
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nixos" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
  };

  users.defaultUserShell = pkgs.zsh;
}
