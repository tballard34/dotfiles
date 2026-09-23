#!/bin/bash

set -euo pipefail
umask 077

DOTFILES="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
HOME_DIR="${DOTFILES_TARGET_DIR:-$HOME}"
BACKUP_DIR=""

if [ "$DOTFILES" = "$HOME_DIR" ]; then
    echo "Keep the dotfiles repository in its own directory." >&2
    exit 1
fi

mkdir -p "$HOME_DIR"

# Preserve existing local settings; otherwise create them from the templates.
for file in .zprofile.local .zshrc.local .env; do
    if [ ! -e "$DOTFILES/$file" ]; then
        if [ -f "$HOME_DIR/$file" ]; then
            cp "$HOME_DIR/$file" "$DOTFILES/$file"
        else
            cp "$DOTFILES/$file.example" "$DOTFILES/$file"
        fi
    fi
done

for file in .zshrc .zprofile .zprofile.local .zshrc.local .env; do
    if [ ! -f "$DOTFILES/$file" ]; then
        echo "Missing configuration: $DOTFILES/$file" >&2
        exit 1
    fi
    if [ -d "$HOME_DIR/$file" ]; then
        echo "Refusing to replace a directory: $HOME_DIR/$file" >&2
        exit 1
    fi
done

for file in .zshrc .zprofile .zprofile.local .zshrc.local .env; do
    target="$HOME_DIR/$file"
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$DOTFILES/$file" ]; then
        continue
    fi
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -z "$BACKUP_DIR" ]; then
            mkdir -p "$HOME_DIR/.dotfiles-backups"
            BACKUP_DIR="$(mktemp -d "$HOME_DIR/.dotfiles-backups/$(date +%Y%m%d-%H%M%S).XXXXXX")"
        fi
        mv "$target" "$BACKUP_DIR/$file"
    fi
    ln -s "$DOTFILES/$file" "$target"
done

echo "Dotfiles installation complete!"
if [ -n "$BACKUP_DIR" ]; then
    echo "Previous files saved in: $BACKUP_DIR"
fi
