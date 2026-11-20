#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

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

echo "Detaching dotfiles..."
for pkg in "${STOW_PACKAGES[@]}"; do
    echo "  -> Detaching $pkg"
    stow -D -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
    cp -r "$pkg/." "$HOME/"
done

echo "✅ Dotfiles detached!"

