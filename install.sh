#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
cd "$DOTFILES_DIR"

# Pre-create parent directories so Stow doesn't symlink whole folders
mkdir -p "$HOME/.config" "$HOME/.local/share" "$HOME/Vault/.obsidian/plugins"

echo "📦 Running GNU Stow..."
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

for pkg in "${STOW_PACKAGES[@]}"; do
    # Find the highest-level files/folders in each package (excluding .config and .local/share themselves)
    while IFS= read -r -d '' item; do
        rel="${item#$pkg/}"
        target="$HOME/$rel"
        if [[ -e "$target" && ! -L "$target" ]]; then
            echo "   -> Backing up $rel"
            mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
            mv "$target" "$BACKUP_DIR/$rel"
        fi
    done < <(find "$pkg" -mindepth 1 -maxdepth 4 \
        ! -path "$pkg/.config" \
        ! -path "$pkg/.local" \
        ! -path "$pkg/.local/share" \
        ! -path "$pkg/Vault" \
        ! -path "$pkg/Vault/.obsidian" \
        ! -path "$pkg/Vault/.obsidian/plugins" \
        -prune -print0)

    echo "   -> Stowing $pkg"
    stow -R -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

echo "✅ Dotfiles installation complete!"

