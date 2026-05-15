#!/usr/bin/env bash

# Ensure current location is set to dotfiles dir
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "📦 Running GNU Stow..."
STOW_PACKAGES=(
    nvim
)

for pkg in "${STOW_PACKAGES[@]}"; do
    echo "   -> Stowing $pkg"
    stow -R -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

echo "✅ Dotfiles installation complete!"
