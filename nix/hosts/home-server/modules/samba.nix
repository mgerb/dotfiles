{...}: {
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "invalid users" = [
          "root"
        ];
        "passwd program" = "/run/wrappers/bin/passwd %u";
        security = "user";
        "workgroup" = "WORKGROUP";
        "server string" = "%h server (Samba, Ubuntu)";
        "map to guest" = "bad user";
      };
      share = {
        path = "/raid-pool/samba";
        browsable = "yes";
        "read only" = "no";
      };
      wd2 = {
        path = "/wd2";
        browsable = "yes";
        "read only" = "no";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
