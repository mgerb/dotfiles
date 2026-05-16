{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zfs
    zfs-prune-snapshots
  ];

  boot.supportedFilesystems = ["zfs"];
  boot.zfs.extraPools = ["mbak1"];
  boot.zfs.forceImportRoot = false;
  services.zfs.autoScrub.enable = true;
}
