{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # file sharing
    samba
    wsdd

    # zfs
    zfs
    zfs-prune-snapshots
  ];
}
