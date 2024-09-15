{...}: {
  imports = [
    ./networking.nix
    ./packages.nix
    ./samba.nix
    ./zfs.nix
  ];
}
