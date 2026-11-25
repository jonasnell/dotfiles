#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

ALL_PACKAGES=(
    bash
    konsole
    nvim
    obsidian
    tmux
    vicinae
    vim
    wezterm
)

if [[ $# -gt 0 ]]; then
    STOW_PACKAGES=()
    for arg in "$@"; do
        pkg="${arg%/}"
        if [[ " ${ALL_PACKAGES[*]} " == *" $pkg "* ]]; then
            STOW_PACKAGES+=("$pkg")
        else
            echo "❌ Unknown package: '$pkg'" >&2
            echo "Available packages: ${ALL_PACKAGES[*]}" >&2
            exit 1
        fi
    done
else
    STOW_PACKAGES=("${ALL_PACKAGES[@]}")
fi

echo "Detaching dotfiles (${STOW_PACKAGES[*]})..."
for pkg in "${STOW_PACKAGES[@]}"; do
    echo "  -> Detaching $pkg"
    stow -D -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
    cp -r "$pkg/." "$HOME/"
done

echo "✅ Dotfiles detached!"
