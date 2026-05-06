{
  pkgs,
  user,
  ...
}: let
  jobName = "remoteBackup";
in {
  systemd.services.${jobName} = {
    description = "Nightly remote backup job";

    path = with pkgs; [
      curl
      rsync
      openssh
    ];

    serviceConfig = {
      Type = "simple";
      User = user;

      ExecStartPre = "${pkgs.bash}/bin/bash /raid-pool/samba/backup_started_webhook.sh";
      ExecStart = "${pkgs.bash}/bin/bash /raid-pool/samba/backup_remote.sh";

      KillSignal = "SIGINT";
      TimeoutStopSec = "30s";
    };
  };

  systemd.timers."${jobName}" = {
    description = "Start remote backup at 2am";

    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "*-*-* 02:00:00";
      Persistent = true;
      Unit = "${jobName}.service";
    };
  };

  systemd.services."${jobName}Stop" = {
    description = "Stop remote backup at 8am";

    path = with pkgs; [
      curl
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl stop ${jobName}.service";
      ExecStartPost = "${pkgs.bash}/bin/bash /raid-pool/samba/backup_finished_webhook.sh";
    };
  };

  systemd.timers."${jobName}Stop" = {
    description = "Stop remote backup at 8am";

    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "*-*-* 08:00:00";
      Persistent = true;
      Unit = "${jobName}Stop.service";
    };
  };
}
