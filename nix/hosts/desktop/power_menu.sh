#!/usr/bin/env bash

choice=$(printf "Shutdown\nReboot\nLogout\nSuspend" | wofi --dmenu --prompt "Power Menu")
case "$choice" in
  Shutdown) systemctl poweroff ;;
  Reboot) systemctl reboot ;;
  Logout) hyprctl dispatch exit ;;
  Suspend) systemctl suspend ;;
esac
