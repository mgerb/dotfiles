{...}: {
  environment.shellAliases = {
    dc = "docker compose";
    # docker compose pull, down, update
    mgdu = "dc pull && dc down && dc up -d";
  };
}
