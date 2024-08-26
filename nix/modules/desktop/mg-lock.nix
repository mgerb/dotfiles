{pkgs, ...}: let
  mgLock = pkgs.writeShellScriptBin "mg-lock" ''
    ${pkgs.swaylock-effects}/bin/swaylock -f --clock --screenshots --indicator --effect-blur 7x5
  '';
in {
  environment.systemPackages = with pkgs; [
    mgLock
  ];
}
