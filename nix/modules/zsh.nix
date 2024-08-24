{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
    zsh-autosuggestions
  ];

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
