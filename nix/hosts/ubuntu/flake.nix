{
  description = "Home Manager configuration of mg";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixpkgs-stable,
    zig,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    user = "mg";
    hmModules = [(import ../../modules/home-manager)];
    zigpkgs = zig.packages.${system};
  in {
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home.nix];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        inherit user hmModules zigpkgs;
        pkgs-stable = import nixpkgs-stable {
          # Refer to the `system` parameter from
          # the outer scope recursively
          inherit system;
          # To use Chrome, we need to allow the
          # installation of non-free software.
          config.allowUnfree = true;
        };
      };
    };
  };
}
