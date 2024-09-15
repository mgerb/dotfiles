{
  inputs,
  user,
  hmModules,
  pkgs-stable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./modules
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.${user} = {
    isNormalUser = true;
    description = user;
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs user pkgs-stable;};
    users.${user} = {
      imports = hmModules;
    };
    backupFileExtension = ".bak";
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = user;

  services.openssh.enable = true;
  services.openssh.settings = {
    UseDns = true;
    PasswordAuthentication = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
