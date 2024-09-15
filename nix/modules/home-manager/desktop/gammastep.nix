{...}: {
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 45.0;
    longitude = 93.0;
    temperature = {
      day = 4500;
      night = 3000;
    };
    settings = {
      general = {
        adjustment-method = "wayland";
      };
    };
  };
}
