{pkgs, ...}: {
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    hyprshot
    hyprpicker
    hyprsunset
    sunsetr
    hyprpolkitagent
    hyprcursor
    brightnessctl
    pamixer
    playerctl
    gnome-themes-extra
    pavucontrol
    libnotify
    nautilus
    blueberry
    wlogout
  ];
}
