# Dank Material Shell
# https://danklinux.com/
# Used with Niri.
{inputs, ...}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.danksearch.homeModules.dsearch
  ];
  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dank-material-shell changes
    };
  };
  programs.dsearch.enable = true;
}
