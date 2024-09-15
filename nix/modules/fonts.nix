# TODO: move to home-mananger
{pkgs-stable, ...}: {
  environment.systemPackages = with pkgs-stable; [
    nerdfonts
  ];

  fonts.packages = with pkgs-stable; [
    fira-code
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];
}
