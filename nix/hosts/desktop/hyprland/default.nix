{pkgs, ...}: {
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
    withUWSM = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # this allows udiskie to work
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    blueberry
    brightnessctl
    gnome-themes-extra
    hyprcursor
    hyprpicker
    hyprpolkitagent
    hyprshot
    hyprsunset
    libnotify
    nautilus
    pamixer
    pavucontrol
    playerctl
    sunsetr
    wlogout
    udiskie

    # tool to select system installed fonts
    # nwg-look
  ];
}
