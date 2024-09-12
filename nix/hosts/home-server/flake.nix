{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    user = "mg";
    hmModules =
      [(import ../../modules/home-manager/home.nix)]
      ++ [(import ../../modules/home-manager/files.nix)];
  in {
    nixosConfigurations = {
      snixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs user hmModules;};
        system = "x86_64-linux";
        modules = [
          ../../modules/base.nix
          ../../modules/shell-aliases.nix
          ../../modules/zsh.nix
          ../../modules/fonts.nix
          ../../modules/systemd.nix

          ./modules/zfs.nix
          ./modules/networking.nix
          ./modules/samba.nix

          ./configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
