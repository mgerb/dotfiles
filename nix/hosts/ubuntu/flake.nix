{
  description = "Home Manager configuration of mg";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    user = "mg";
    hmModules =
      [(import ../../modules/home-manager/home.nix)]
      ++ [(import ../../modules/home-manager/files.nix)]
      ++ [(import ../../modules/home-manager/zsh.nix)]
      ++ [(import ../../modules/home-manager/fonts.nix)]
      ++ [(import ../../modules/home-manager/shell-aliases.nix)]
      ++ [(import ../../modules/home-manager/packages.nix)];
  in {
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home.nix];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        inherit user hmModules;
      };
    };
  };
}
