{
  pkgs,
  inputs,
  ...
}: {
  programs.niri = {
    enable = true;
  };

  programs.dms-shell = {
    enable = true;
  };
  programs.dsearch.enable = true;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri"; # Or "hyprland" or "sway"
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    # kwallet
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
