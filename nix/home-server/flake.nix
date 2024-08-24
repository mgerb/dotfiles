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
  } @ inputs: {
    nixosConfigurations = {
      # hostname
      snixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ../modules/base.nix
          ../modules/packages.nix
          ../modules/neovim.nix
          ../modules/shell-aliases.nix
          ../modules/zsh.nix
          ../modules/fonts.nix
          ../modules/systemd.nix

          ./modules/zfs.nix
          ./modules/networking.nix
          ./modules/packages.nix
          ./modules/samba.nix

          ./configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
