{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };
}
