{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs.noctalia-greeter = {
    enable = true;
  };

  # services.displayManager.dms-greeter = {
  #   enable = true;
  #   compositor.name = "niri"; # Or "hyprland" or "sway"
  # };
}
