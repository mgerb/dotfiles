{...}: {
  boot.supportedFilesystems = ["ntfs"];
  # Use lsblk -f to scan for new drives.
  fileSystems."/mnt/usb1" = {
    device = "/dev/disk/by-uuid/421A9B181A9B07D5";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000" "gid=100" "nofail"];
  };
  fileSystems."/mnt/usb2" = {
    device = "/dev/disk/by-uuid/8222666522665DE3";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000" "gid=100" "nofail"];
  };
}
