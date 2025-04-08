{...}: {
  home.shellAliases = {
    hm = "home-manager";
    dc = "docker compose";
    # docker compose pull, down, update
    mgdu = "dc pull && dc down && dc up -d";
    mgspace = "du -h -d 1 | sort -h";
  };
}
