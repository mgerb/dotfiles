{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # file sharing
    samba
    wsdd

    usbutils # for lsusb

    # zfs
    zfs
    zfs-prune-snapshots

    wl-clipboard
  ];
}
