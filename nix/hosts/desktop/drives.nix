{...}: {
  # fileSystems."/mnt/860-evo" = {
  #   device = "/dev/disk/by-uuid/0E5E38E65E38C7EB";
  #   fsType = "ntfs3";
  #   options = [
  #     "nofail"
  #     "x-systemd.automount"
  #   ];
  # };

  fileSystems."/mnt/samsung-m2" = {
    device = "/dev/disk/by-uuid/E856-1E78";
    fsType = "exfat";
    options = [
      "nofail"
      # Lazily mount.
      # "x-systemd.automount"
    ];
  };
}
