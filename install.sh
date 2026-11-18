#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
cd "$DOTFILES_DIR"

mkdir -p "$HOME/.config" "$HOME/.local/share"

echo "📦 Running GNU Stow..."
STOW_PACKAGES=(
    bash
    konsole
    nvim
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
    done < <(find "$pkg" -mindepth 1 -maxdepth 3 \
        ! -path "$pkg/.config" \
        ! -path "$pkg/.local" \
        ! -path "$pkg/.local/share" \
        -prune -print0)

    echo "   -> Stowing $pkg"
    stow -R -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

echo "✅ Dotfiles installation complete!"

