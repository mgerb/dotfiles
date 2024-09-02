# lsit snapshots
# `zfs list -t snapshot`
#
# Prune snapshots over a week old
# `zfs-prune-snapshots 1w`
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zfs
    zfs-prune-snapshots
  ];
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.extraPools = ["raid-pool" "wd1" "wd2"];

  services.zfs.autoScrub.enable = true;

  services.zfs.autoSnapshot = {
    enable = true;
    frequent = 4;
    hourly = 24;
    daily = 7;
    weekly = 4;
    monthly = 4;
  };
}
