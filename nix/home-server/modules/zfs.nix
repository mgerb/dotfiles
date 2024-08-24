{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zfs
  ];
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.extraPools = ["raid-pool" "wd1" "wd2"];
}
