{pkgs, ...}: {
  wayland.windowManager.sway = {
    enable = true;
    extraConfig = ''
      bindsym XF86MonBrightnessDown exec brightnessctl set 10%-
      bindsym XF86MonBrightnessUp exec brightnessctl set +10%


      bar {
        position top
        status_command ${pkgs.i3status}/bin/i3status
        swaybar_command ${pkgs.sway}/bin/swaybar
      }

      exec nm-applet --indicator
      exec blueman-applet
    '';
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      # set bars to none so that we can set it in extraConfig
      bars = [];
      # startup = [
      #   {command = "kitty";}
      # ];
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock-effects}/bin/swaylock -f --clock --screenshots --indicator --effect-blur 7x5";
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -f --clock --screenshots --indicator --effect-blur 7x5";
      }
    ];
  };
}
