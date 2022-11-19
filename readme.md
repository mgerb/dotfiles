# Dotfiles

## Setup

- [Install Kitty](https://sw.kovidgoyal.net/kitty/)
- Install Neovim
  - [Download appimage from releases page](https://github.com/neovim/neovim/releases)
  - `mv nvim.appimage /usr/local/bin/nvim`
  - `sudo chmod +x /usr/local/bin/nvim`
- [Install Neovide](https://github.com/neovide/neovide)
  - place neovide in `/usr/local/bin`
- [Install zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
  - [Install ohmyzsh](https://ohmyz.sh/#install)
  - [Install dracula zsh theme](https://draculatheme.com/zsh)
    - `git clone https://github.com/dracula/zsh.git ./.oh-my-zsh/dracula-theme`
  - [Install zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
    - `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
- [Install starship](https://starship.rs/guide/#%F0%9F%9A%80-installation)
- ~~[Install fish](https://fishshell.com/)~~ (I switched to zsh and no longer use fish)
- Link files to destinations:

```
ln -s $HOME/Desktop/git/dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/Desktop/git/dotfiles/.config/starship.toml $HOME/.config/starship.toml
ln -s $HOME/Desktop/git/dotfiles/.config/nvim $HOME/.config/nvim
ln -s $HOME/Desktop/git/dotfiles/.config/kitty $HOME/.config/kitty
ln -s $HOME/Desktop/git/dotfiles/.oh-my-zsh/dracula-theme/dracula.zsh-theme $HOME/.oh-my-zsh/themes/dracula.zsh-theme

--- deprecated ---
ln -s $HOME/Desktop/git/dotfiles/.config/fish $HOME/.config/fish
```
