{...}: {
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        security = "user";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "usb1" = {
        "path" = "/mnt/usb1";
        "browseable" = "yes";
        "read only" = "no";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
}
