{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    zig.url = "github:mitchellh/zig-overlay";
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    zig,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "mg";
    hmModules = [
      # NOTE: Add home-manager modules here. Add NixOS modules below.
      (import ../../modules/home-manager)
      (import ./home-manager/files.nix)
      (import ../../modules/home-manager/desktop)
      # (import ../../modules/home-manager/desktop/dms-shell.nix)
    ];
    zigpkgs = zig.packages.${system};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit inputs user hmModules zigpkgs;
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
        # NOTE: Add NixOS modules here. Add home-manager modules above.
        modules = [
          ../../modules/base.nix
          ../../modules/tailscale-client.nix
          # Disable niri/dms for now.
          # ../../modules/niri.nix

          ./configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s
        ];
      };
    };
  };
}
