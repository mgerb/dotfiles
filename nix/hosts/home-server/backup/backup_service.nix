# User mode service so that we can start over SSH without root permissions.
# Unlike root, it will not show transfer data in the web hook.
{
  lib,
  pkgs,
  user,
  ...
}: let
  backupNames = import ./backup_names.nix;
  jobName = backupNames.manualJobName;
  backupPath = lib.makeBinPath (with pkgs; [
    coreutils
    curl
    util-linux
    rsync
    openssh
  ]);
  stopPath = lib.makeBinPath (with pkgs; [
    coreutils
    curl
    gnused
    systemd
  ]);
in {
  users.users.${user}.linger = true;

  home-manager.users.${user}.systemd.user = {
    services.${jobName} = {
      Unit = {
        Description = "Manual remote backup job";
      };

      Service = {
        Type = "simple";
        Environment = "PATH=${backupPath}";

        ExecStartPre = "${pkgs.bash}/bin/bash /raid-pool/samba/backup_started_webhook.sh";
        ExecStart = "${pkgs.bash}/bin/bash /raid-pool/samba/backup_remote.sh";

        KillSignal = "SIGINT";
        TimeoutStopSec = "30s";
      };
    };

    services."${jobName}Stop" = {
      Unit = {
        Description = "Stop remote backup at 8am";
        Conflicts = ["${jobName}.service"];
        After = ["${jobName}.service"];
      };

      Service = {
        Type = "oneshot";
        Environment = "PATH=${stopPath}";
        ExecStart = "${pkgs.bash}/bin/bash /raid-pool/samba/backup_finished_webhook.sh '--user -u ${jobName}.service'";
      };
    };
  };
}
