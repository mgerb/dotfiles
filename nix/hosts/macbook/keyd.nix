{...}: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        extraConfig = ''
          # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
          # run `sudo keyd monitor` to get keyboard id
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
