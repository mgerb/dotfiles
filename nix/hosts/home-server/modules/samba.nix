{...}: {
  services.samba = {
    enable = true;
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = %h server (Samba, Ubuntu)
      map to guest = bad user
    '';

    # add user with: sudo smbpasswd -a my_user
    shares = {
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
