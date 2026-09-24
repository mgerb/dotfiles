{
  pkgs,
  pkgs-stable,
  lib,
  osConfig ? {},
  ...
}: {
  home.packages = with pkgs; [
    kitty
    ghostty
    # alacritty
    discord
    signal-desktop
    xeyes

    # browsers
    # google-chrome

    # This is a fix for brave not using the nvidia GPU to decode video.
    (
      if builtins.elem "nvidia" (osConfig.services.xserver.videoDrivers or [])
      then
        (brave-origin.override {
          commandLineArgs = lib.concatStringsSep " " [
            "--enable-features=AcceleratedVideoDecodeLinuxGL,VaapiOnNvidiaGPUs"
            "--use-gl=angle"
            "--use-angle=gl"
            "--ozone-platform=wayland"
            "--ignore-gpu-blocklist"
          ];
        }).overrideAttrs (old: {
          preFixup =
            (old.preFixup or "")
            + ''
              gappsWrapperArgs+=(--set LIBVA_DRIVER_NAME nvidia)
            '';
        })
      else brave-origin
    )

    wine64
    spotify
    exiftool
    obsidian
    xwayland
    vlc

    # old sway stuff
    # swaylock-effects
    # wlsunset
    # gammastep
    # wl-gammactl
    # mako # notification system developed by swaywm maintainer
    # grim # screenshot functionality
    # slurp # screenshot functionality
    # wofi
    # polkit
    # wireless network TUI
    # impala # iwd TUI
    # iwd
    # networkmanagerapplet
    # blueman
  ];
}
