#!/bin/bash

DOTFILES="$HOME/dotfiles"

echo "Installing dotfiles..."

# Create symlinks
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES/.zshrc.local" "$HOME/.zshrc.local"

# Handle example files
if [ ! -f "$HOME/.env" ]; then
    cp "$DOTFILES/.env.example" "$HOME/.env"
    echo "Created .env from example. Please update with your values."
fi

if [ ! -f "$HOME/.zshrc.local" ]; then
    cp "$DOTFILES/.zshrc.local.example" "$HOME/.zshrc.local"
    echo "Created .zshrc.local from example. Please update with your values."
fi

echo "Dotfiles installation complete!"