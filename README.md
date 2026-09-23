# Dotfiles

My personal dotfiles configuration for zsh and development environment setup.

## Installation

1. Clone this repository:

```bash
git clone https://github.com/tballard34/dotfiles.git ~/dotfiles
```

2. Run the installation script:

```bash
cd ~/dotfiles
./install.sh
```

## What's Included

- `.zshrc`: Main zsh configuration
- `.zshrc.local.example`: _Template_ Local zsh customizations
- `.zprofile`: Login shell configuration
- `.zprofile.local.example`: _Template_ Local login-shell customizations
- `.env.example`: _Template_ for environment variables

## Customization

After installation:
1. Edit `~/.env` with trusted, shell-compatible environment assignments (quote values containing spaces). This file is sourced by zsh and must not contain untrusted code.
2. Edit `~/.zshrc.local` with your machine-specific interactive shell configurations.
3. Edit `~/.zprofile.local` with machine-specific login-shell configurations, such as OrbStack and PostgreSQL tool paths.

The installer preserves existing local override files and creates missing ones from the examples. Files replaced in your home directory are moved to `~/.dotfiles-backups/` first. Review those backups and carry any machine-specific settings into the local overrides. Running the installer again leaves correct symlinks alone.

Shared `.zshrc` and `.zprofile` settings are versioned. The local overrides and `.env` are ignored by Git. `.zprofile.example` is a legacy template; the tracked `.zprofile` is now the shared login configuration. On an older checkout, back up its ignored `.zprofile` and move its machine-specific settings into `.zprofile.local` before pulling this change.

Open a new terminal after installing. Optional tools are loaded only when available; the installer does not install packages. Enable Corepack explicitly for each Node version when needed instead of modifying it on every shell startup.

## Requirements

- zsh shell
- Git
