# packages for hyprland environment
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kitty
    dunst
    pipewire
    wireplumber
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    wofi
    waybar
    brightnessctl
    pavucontrol

    hyprland
    hyprpaper
    hypridle
    hyprlock
    hyprshade
    hyprcursor
    grimblast # screenshots
    libnotify
  ];

  programs.hyprland.enable = true;
}
