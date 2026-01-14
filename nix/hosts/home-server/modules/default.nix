{...}: {
  imports = [
    ./networking.nix
    ./packages.nix
    ./samba.nix
    ./zfs.nix
    ./wireguard.nix
    ./fail2ban.nix
  ];
}
