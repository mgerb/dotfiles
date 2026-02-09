# Configure exit node: `sudo tailscale set --exit-node=snixos`
{...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    extraSetFlags = [
      "--accept-routes"
    ];
  };
}
