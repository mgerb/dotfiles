{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    user = "mg";
    hmModules =
      [(import ../../modules/home-manager/home.nix)]
      ++ [(import ../../modules/home-manager/gammastep.nix)]
      ++ [(import ../../modules/home-manager/files.nix)]
      ++ [(import ../../modules/home-manager/files-desktop.nix)]
      ++ [(import ../../modules/home-manager/sway.nix)];
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs user hmModules;};
        system = "x86_64-linux";
        modules = [
          ../../modules/base.nix
          ../../modules/zsh.nix
          ../../modules/fonts.nix
          ../../modules/neovim.nix
          ../../modules/shell-aliases.nix
          ../../modules/systemd.nix

          ../../modules/desktop

          ./configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s
        ];
      };
    };
  };
}
