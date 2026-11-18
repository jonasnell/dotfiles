# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Included Configs

- **bash** – Shell config, aliases, functions, and readline settings
- **konsole** – Terminal profile and color schemes
- **nvim** – Neovim setup
- **tmux** – Terminal multiplexer config
- **vicinae** – Launcher settings
- **vim** – Vim config
- **wezterm** – WezTerm terminal config
- **keyd** – System-wide key remapping (requires manual copy to `/etc/keyd/`)

## Installation

1. Install `git` and `stow`.
2. Clone this repository and run the install script:

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh

```

The script automatically backs up any conflicting files or config directories to `~/.dotfiles_backup/` before symlinking everything into `$HOME`.

### keyd

Because `keyd` lives outside `$HOME`, copy it manually when needed:

```bash
sudo install -Dm644 ~/dotfiles/keyd/etc/keyd/default.conf /etc/keyd/default.conf
sudo keyd reload
```

