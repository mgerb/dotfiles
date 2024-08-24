{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim

    # formatters
    alejandra
    stylua
    prettierd
  ];
}
