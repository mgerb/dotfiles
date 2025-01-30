{
  inputs,
  pkgs,
  pkgs-stable,
  user,
  hmModules,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    extraSpecialArgs = {inherit inputs user pkgs-stable;};
    users.${user} = {
      imports = hmModules;
    };
    backupFileExtension = ".bak";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # docker
  virtualisation.docker.enable = true;
  users.users.${user}.extraGroups = ["docker"];

  # kvm
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        extraConfig = ''
          # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
          [ids]
          # *
          0fac:0ade:efba1ddf # thinkpad

          [main]
          capslock = overload(capslock, esc)

          [capslock:C]
          h = left
          j = down
          k = up
          l = right
        '';
      };
    };
  };
}
