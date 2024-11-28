#!/bin/bash

# Get the actual username instead of assuming 'owner'
CURRENT_USER=$(whoami)
HOME_DIR="/Users/$CURRENT_USER"

# If HOME environment variable exists, use that instead
if [ -n "$HOME" ]; then
    HOME_DIR="$HOME"
fi

DOTFILES="$HOME_DIR/dotfiles"

echo "Installing dotfiles for user: $CURRENT_USER"
echo "Home directory: $HOME_DIR"
echo

# Create symlinks
ln -sf "$DOTFILES/.zshrc" "$HOME_DIR/.zshrc"
ln -sf "$DOTFILES/.zprofile" "$HOME_DIR/.zprofile"
ln -sf "$DOTFILES/.zshrc.local" "$HOME_DIR/.zshrc.local"
ln -sf "$DOTFILES/.env" "$HOME_DIR/.env"

echo "Dotfiles installation complete!"