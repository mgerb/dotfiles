{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nerdfonts
  ];

  fonts.packages = with pkgs; [
    fira-code
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];
}
