{pkgs, ...}: {
  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["FiraCode"];
      sansSerif = ["FiraCode"];
      monospace = ["FiraCode"];
    };
  };
}
