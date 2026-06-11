{
  lib,
  pkgs,
  user,
  ...
}: let
  jobName = "remoteBackup";
  backupPath = lib.makeBinPath (with pkgs; [
    coreutils
    curl
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
        Description = "Nightly remote backup job";
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

    timers.${jobName} = {
      Unit = {
        Description = "Start remote backup at 2am";
      };

      Timer = {
        OnCalendar = "*-*-* 01:00:00";
        Persistent = true;
        Unit = "${jobName}.service";
      };

      Install = {
        WantedBy = ["timers.target"];
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
        ExecStart = "${pkgs.bash}/bin/bash /raid-pool/samba/backup_finished_webhook.sh";
      };
    };

    timers."${jobName}Stop" = {
      Unit = {
        Description = "Stop remote backup at 8am";
      };

      Timer = {
        OnCalendar = "*-*-* 08:00:00";
        Persistent = true;
        Unit = "${jobName}Stop.service";
      };

      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}
