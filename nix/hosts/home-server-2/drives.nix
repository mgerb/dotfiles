{...}: {
  # Use lsblk -f to scan for new drives.
  fileSystems."/mnt/usb1" = {
    device = "/dev/disk/by-uuid/421A9B181A9B07D5";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000" "gid=100" "nofail"];
  };
}
