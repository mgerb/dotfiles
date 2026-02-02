{...}: {
  networking.hostName = "snixos"; # Define your hostname.

  # head -c 8 /etc/machine-id
  # required by ZFS
  networking.hostId = "bd3e069c";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # ssh
      2999 # mgdocker
      1883 # mqtt
      #18789
      #18790
    ];
    allowedTCPPortRanges = [
      {
        # docker containers
        from = 5000;
        to = 5100;
      }
    ];
  };
}
