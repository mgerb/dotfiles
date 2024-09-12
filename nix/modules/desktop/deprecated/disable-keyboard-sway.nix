# DEPRECATED: only use for this reference if setting this up with systemd
#
# Disable onboard keyboard when external keyboard is plugged in.
# Uses udev and systemd to run a script that toggles the onboard keyboard.
# {
#   pkgs,
#   user,
#   ...
# }: {
#   # add our package so we can use it manually - this has nothing to do with udev
#   environment.systemPackages = [
#     pkgs.libnotify
#   ];
#
#   # run systemd like this because I had issues with the other method below
#   services.udev.extraRules = ''
#     # Rule for any keyboard plug in
#     ACTION=="add", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", RUN+="${pkgs.systemd}/bin/systemctl start mgKeyboard@'disable'"
#
#     # Rule for any keyboard unplug
#     ACTION=="remove", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", RUN+="${pkgs.systemd}/bin/systemctl start mgKeyboard@'enable'"
#   '';
#
#   # NOTE: this worked for enabling, but not for disabling for some reason
#   # services.udev.extraRules = ''
#   #   ACTION=="add", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", TAG+="systemd", ENV{SYSTEMD_WANTS}="mgKeyboard@'disable'"
#   #   ACTION=="remove", SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", TAG+="systemd", ENV{SYSTEMD_WANTS}="mgKeyboard@'enable'"
#   # '';
#
#   # TODO: disable for now - probably permissions issue with sway
#   # systemd.services."mgKeyboard@" = {
#   #   description = "mg-keyboard Service";
#   #   after = ["network.target"];
#   #   wantedBy = ["multi-user.target"];
#   #   serviceConfig = {
#   #     User = user;
#   #     Environment = [
#   #       "SCRIPT_ARGS=%I"
#   #       "DISPLAY=:0"
#   #     ];
#   #     ExecStart = ''
#   #       ${pkgs.bash}/bin/bash -c '${pkgs.mgKeyboard}/bin/mg-keyboard $SCRIPT_ARGS'
#   #     '';
#   #     Type = "oneshot";
#   #   };
#   # };
# }
