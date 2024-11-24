# lsit snapshots
# `zfs list -t snapshot`
#
# Prune snapshots over a week old
# `zfs-prune-snapshots 1w`
{...}: {
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.extraPools = ["raid-pool" "wd1" "wd2"];

  services.zfs.autoScrub.enable = true;

  # NOTE: must enable zfs auto snapshots
  # check if enabled `sudo zfs get com.sun:auto-snapshot=true`
  # sudo zfs set com.sun:auto-snapshot=true raid-pool
  # sudo zfs set com.sun:auto-snapshot=true wd1
  # sudo zfs set com.sun:auto-snapshot=true wd2
  services.zfs.autoSnapshot = {
    enable = true;
    flags = "-k -p";

    frequent = 4;
    hourly = 24;
    daily = 7;
    weekly = 4;
    monthly = 4;
  };
}
