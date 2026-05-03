{...}: {
  home.shellAliases = {
    hm = "home-manager";
    # --progress=plain - This fixes output in the Neovim terminal.
    dc = "docker compose --progress=plain";
    # docker compose pull, down, update
    mgdu = "dc pull && dc down && dc up -d";
    mgspace = "du -h -d 1 | sort -h";
  };
}
