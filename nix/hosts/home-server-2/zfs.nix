{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zfs
    zfs-prune-snapshots
  ];

  boot.supportedFilesystems = ["zfs"];
  boot.zfs.extraPools = ["mbak1"];
  services.zfs.autoScrub.enable = true;
}
