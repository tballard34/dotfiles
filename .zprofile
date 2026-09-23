# Homebrew supports both Apple Silicon and Intel Macs.
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv zsh)"
fi

export PATH="$HOME/.local/bin:$PATH"

# Login shells also serve SSH and automation commands.
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --shell zsh)"
fi

if [ -f "$HOME/.zprofile.local" ]; then
    source "$HOME/.zprofile.local"
fi
