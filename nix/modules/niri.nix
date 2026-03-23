{pkgs, ...}: {
  programs.niri = {
    enable = true;
  };

  # services.displayManager.dms-greeter = {
  #   enable = true;
  #   compositor.name = "niri"; # Or "hyprland" or "sway"
  # };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  # file browser
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.udisks2.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}
