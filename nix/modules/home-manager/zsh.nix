{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = ["git"];
    oh-my-zsh.theme = "robbyrussell";
  };
}
