{pkgs, ...}: {
  services.fail2ban = {
    enable = true;
    ignoreIP = [
      "10.0.0.0/8"
      "172.16.0.0/12"
      "192.168.0.0/16"
    ];
    maxretry = 5;
    bantime = "24h"; # Ban IPs for one day on the first ban
    bantime-increment = {
      enable = true; # Enable increment of bantime after each violation
      # formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
    jails = {
      caddy.settings = {
        enabled = true;
        port = "http,https";
        logpath = "/raid-pool/samba/webservers/caddy/logs/*.log";
        backend = "auto";
      };
    };
  };

  # https://gist.github.com/henk23/06a2b4eb251bc6aa7ec441ea560cedab
  environment.etc = {
    "fail2ban/filter.d/caddy.local".text = pkgs.lib.mkDefault (pkgs.lib.mkAfter ''
      [Definition]
      failregex = "client_ip":"<HOST>"(?:.*)"status":(?:403|404)
      datepattern = "ts":{Epoch}
    '');
  };
}
