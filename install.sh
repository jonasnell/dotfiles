#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
cd "$DOTFILES_DIR"

# Pre-create parent directories so Stow doesn't symlink whole folders
mkdir -p "$HOME/.config" "$HOME/.local/share" "$HOME/.local/share/vicinae" "$HOME/Vault/.obsidian/plugins"

STOW_PACKAGES=(
    bash
    konsole
    nvim
    obsidian
    tmux
    vicinae
    vim
    wezterm
)

echo "Installing dotfiles..."
for pkg in "${STOW_PACKAGES[@]}"; do
    while IFS= read -r -d '' item; do
        rel="${item#$pkg/}"
        target="$HOME/$rel"
        if [[ -e "$target" && ! -L "$target" ]]; then
            echo "  -> Backing up $rel"
            mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
            mv "$target" "$BACKUP_DIR/$rel"
        fi
    done < <(find "$pkg" -mindepth 1 -maxdepth 4 \
        ! -path "$pkg/.config" \
        ! -path "$pkg/.local" \
        ! -path "$pkg/.local/share" \
        ! -path "$pkg/.local/share/vicinae" \
        ! -path "$pkg/Vault" \
        ! -path "$pkg/Vault/.obsidian" \
        ! -path "$pkg/Vault/.obsidian/plugins" \
        -prune -print0)

    echo "  -> Stowing $pkg"
    stow -R -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

echo "✅ Dotfiles installed!"

