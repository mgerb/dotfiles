{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "mg";
    hmModules =
      [(import ../../modules/home-manager/home.nix)]
      ++ [(import ../../modules/home-manager/files.nix)];
  in {
    nixosConfigurations = {
      snixos = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit inputs user hmModules;
          # To use packages from nixpkgs-stable,
          # we configure some parameters for it first
          pkgs-stable = import nixpkgs-stable {
            # Refer to the `system` parameter from
            # the outer scope recursively
            inherit system;
            # To use Chrome, we need to allow the
            # installation of non-free software.
            config.allowUnfree = true;
          };
        };
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
