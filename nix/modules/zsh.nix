# TODO: move to home-mananger
{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = ["git"];
    ohMyZsh.theme = "robbyrussell";
    syntaxHighlighting.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
}
