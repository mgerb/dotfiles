{...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraSetFlags = [
      "--accept-routes"
      # To disable the exit node: `sudo tailscale set --exit-node=`
      "--exit-node=snixos"
    ];
  };
}
