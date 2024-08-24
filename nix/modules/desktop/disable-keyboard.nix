# Disable onboard keyboard when external keyboard is plugged in.
# Uses udev and systemd to run a script that toggles the onboard keyboard.
{pkgs, ...}: let
  mgKeyboard = pkgs.writeShellScriptBin "mg-keyboard" ''
    # required for notify-send
     export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u $(whoami))/bus"

     enable_keyboard() {
         ${pkgs.libnotify}/bin/notify-send -u normal "Enabling Keyboard"
         ${pkgs.hyprland}/bin/hyprctl --instance 0 keyword '$LAPTOP_KB_ENABLED' "true" -r
     }

     disable_keyboard() {
         ${pkgs.libnotify}/bin/notify-send -u normal "Disabling Keyboard"
         ${pkgs.hyprland}/bin/hyprctl --instance 0 keyword '$LAPTOP_KB_ENABLED' "false" -r
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
  # add our package so we can use it manually - this has nothing to do with udev
  environment.systemPackages = [
    mgKeyboard
    pkgs.libnotify
    pkgs.hyprland
  ];

  # run systemd like this because I had issues with the other method below
  services.udev.extraRules = ''
    # Rule for any keyboard plug in
    ACTION=="add", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", RUN+="${pkgs.systemd}/bin/systemctl start mgKeyboard@'disable'"

    # Rule for any keyboard unplug
    ACTION=="remove", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", RUN+="${pkgs.systemd}/bin/systemctl start mgKeyboard@'enable'"
  '';

  # NOTE: this worked for enabling, but not for disabling for some reason
  # services.udev.extraRules = ''
  #   ACTION=="add", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", TAG+="systemd", ENV{SYSTEMD_WANTS}="mgKeyboard@'disable'"
  #   ACTION=="remove", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", TAG+="systemd", ENV{SYSTEMD_WANTS}="mgKeyboard@'enable'"
  # '';

  systemd.services."mgKeyboard@" = {
    description = "mg-keyboard Service";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      User = "mg";
      Environment = [
        "SCRIPT_ARGS=%I"
        "DISPLAY=:0"
      ];
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c '${mgKeyboard}/bin/mg-keyboard $SCRIPT_ARGS'
      '';
      Type = "oneshot";
    };
  };
}
