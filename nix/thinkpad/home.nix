{
  config,
  pkgs,
  lib,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mg";
  home.homeDirectory = "/home/mg";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim" = {
      # this must be a symlink because neovim makes file modifications at runtime
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/config/nvim";
    };

    ".config/starship.toml".source = ../../config/starship.toml;
    ".tmux.conf".source = ../../.tmux.conf;
    ".config/kitty/kitty.conf".source = ../../config/kitty/kitty.conf;
    ".config/waybar/config.jsonc".source = ../../config/waybar/config.jsonc;
    ".config/waybar/style.css".source = ../../config/waybar/style.css;

    # hyprland
    ".config/hypr/hyprland.conf".source = ../../hypr/hyprland.conf;
    ".config/hypr/hyprpaper.conf".source = ../../hypr/hyprpaper.conf;
    ".config/hypr/hypridle.conf".source = ../../hypr/hypridle.conf;
    ".config/hypr/hyprlock.conf".source = ../../hypr/hyprlock.conf;
    ".config/hypr/hyprshade.toml".source = ../../hypr/hyprshade.toml;
    ".config/hypr/shaders".source = ../../hypr/shaders;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/nixos/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "neovim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    extraConfig = ''
      bindsym XF86MonBrightnessDown exec brightnessctl set 10%-
      bindsym XF86MonBrightnessUp exec brightnessctl set +10%


      bar {
        position top
        status_command ${pkgs.i3status}/bin/i3status
        swaybar_command ${pkgs.sway}/bin/swaybar
      }

      exec nm-applet --indicator
      exec blueman-applet
    '';
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty";
      # set bars to none so that we can set it in extraConfig
      bars = [];
      startup = [
        {command = "kitty";}
      ];
    };
  };

  # currently broken
  # services.gammastep = {
  #   enable = true;
  #   provider = "manual";
  #   latitude = 45.0;
  #   longitude = 93.0;
  #   settings = {
  #     general = {
  #       adjustment-method = "wayland";
  #     };
  #   };
  # };

  # services.wlsunset = {
  #   enable = true;
  #   latitude = "45.00";
  #   longitude = "93.00";
  #   temperature = {
  #     day = 4500;
  #     night = 3000;
  #   };
  # };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f --clock --screenshots --indicator --effect-blur 7x5";
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f --clock --screenshots --indicator --effect-blur 7x5";
      }
    ];
  };
}
