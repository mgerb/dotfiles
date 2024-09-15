{pkgs, ...}: let
  mgLock = pkgs.writeShellScriptBin "mg-lock" ''
    ${pkgs.swaylock-effects}/bin/swaylock -f --clock --screenshots --indicator --effect-blur 7x5
  '';

  mgPower = pkgs.writeShellScriptBin "mg-power" ''
    #!/bin/bash

    entries="⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown"

    selected=$(echo -e $entries|wofi --width 250 --height 240 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

    case $selected in
      logout)
        pkill -u kia;;
      suspend)
        exec systemctl suspend;;
      reboot)
        exec systemctl reboot;;
      shutdown)
        exec systemctl poweroff;;
        # it used to be poweroff -i
    esac
  '';

  mgKeyboard = pkgs.writeShellScriptBin "mg-keyboard" ''
    # required for notify-send
     export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u $(whoami))/bus"

     enable_keyboard() {
         ${pkgs.libnotify}/bin/notify-send -t 1000 -u normal "Enabling Keyboard"
         ${pkgs.sway}/bin/sway input "1:1:AT_Translated_Set_2_keyboard" events enabled
     }

     disable_keyboard() {
         ${pkgs.libnotify}/bin/notify-send -t 1000 -u normal "Disabling Keyboard"
         ${pkgs.sway}/bin/sway input "1:1:AT_Translated_Set_2_keyboard" events disabled
     }

     if [ -z "$1" ]; then
       echo "Available options:"
       echo "toggle: toggles the keyboard state"
       echo "enable: enables the keyboard"
       echo "disable: disables the keyboard"
       exit 1
     fi

     if [ "$1" = "toggle" ]; then
         if ! [ -f "$STATUS_FILE" ]; then
           enable_keyboard
         else
           if [ $(cat "$STATUS_FILE") = "true" ]; then
             disable_keyboard
           elif [ $(cat "$STATUS_FILE") = "false" ]; then
             enable_keyboard
           fi
         fi
     elif [ "$1" = "enable" ]; then
         enable_keyboard
     elif [ "$1" = "disable" ]; then
         disable_keyboard
     fi
  '';
in {
  home.packages = with pkgs; [
    libnotify
    mgLock
    mgPower
    mgKeyboard
  ];
}
