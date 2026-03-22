{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    # This is for mapping drives, which aren't in the git repo.
    # NOTE: When this is modified, flake.lock needs to be updated.
    #
    # e.g.
    # {
    #   outputs = {self}: {
    #     nixosModules.default = {...}: {
    #       fileSystems."/mnt/example-drive" = {
    #         device = "/dev/disk/by-uuid/REPLACE-ME";
    #         fsType = "ext4";
    #       };
    #     };
    #   };
    # }
    private-drives.url = "path:/home/mg/.config/nix-private-drives";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    private-drives,
    zig,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "mg";
    hmModules =
      [(import ../../modules/home-manager)]
      # ++ [(import ./hyprland/home-manager)]
      ++ [(import ./home-manager/files.nix)]
      ++ [(import ../../modules/home-manager/desktop)];
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
        modules = [
          ../../modules/base.nix
          ../../modules/tailscale-client.nix
          ../../modules/niri.nix

          ./configuration.nix
          private-drives.nixosModules.default
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
