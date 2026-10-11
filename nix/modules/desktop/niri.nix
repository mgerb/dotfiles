{
  pkgs,
  inputs,
  ...
}: {
  # Force electron apps to use Wayland.
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.niri = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}
