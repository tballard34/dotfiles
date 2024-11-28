#====================
# Aliases
#====================

alias ll='ls -lasht'
alias gs='git status'

SCRIPTS_DIR="$HOME/dev/scripts"
[ -f "$SCRIPTS_DIR/speech_to_text/speech_to_text_whisperAPI.sh" ] && \
    alias speech_to_text="$SCRIPTS_DIR/speech/speech_to_text_whisperAPI.sh"

[ -f "$SCRIPTS_DIR/speech_to_text/speech_to_text_whisperLocal.sh" ] && \
    alias speech_to_text_local="$SCRIPTS_DIR/speech_to_text_whisperLocal.sh"

#====================
# History Configuration
#====================

# Set history file location and size
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
HISTORY_IGNORE='(rm *|rm -rf *)'

# History Options
setopt SHARE_HISTORY          # Immediately share history between all active terminal sessions (real-time sync)
setopt APPEND_HISTORY         # Add commands to history file at shell exit (vs overwriting)
setopt INC_APPEND_HISTORY     # Write commands to history file immediately, not at shell exit
setopt EXTENDED_HISTORY       # Save timestamp and runtime for each command

# Duplicate Management
setopt HIST_EXPIRE_DUPS_FIRST # When history file is full, remove duplicates before unique commands
setopt HIST_IGNORE_DUPS       # Don't save a command if it's identical to the previous one
setopt HIST_FIND_NO_DUPS      # When searching history, only show unique matches (skips duplicates)

# Safety and Special Cases
setopt HIST_IGNORE_SPACE      # Commands preceded by a space won't be saved (useful for sensitive commands)
setopt HIST_VERIFY           # When using history expansion (!$, !!), show command before executing

# Key Bindings for History Search
bindkey '\e[A' history-beginning-search-backward  # Up arrow
bindkey '\e[B' history-beginning-search-forward   # Down arrow


#====================
# Custom Functions
#====================

# Kill process on specified port (only if lsof is available)
if command -v lsof >/dev/null 2>&1; then
    killport() {
        if [ -z "$1" ]; then
            echo "Usage: killport <port>"
            return 1
        fi

        local port=$1
        local pid

        pid=$(lsof -ti tcp:"$port")

        if [ -z "$pid" ]; then
            echo "No process found running on port $port."
            return 1
        fi

        echo "Killing process on port $port with PID $pid..."
        kill -9 $pid

        if [ $? -eq 0 ]; then
            echo "Process on port $port killed successfully."
        else
            echo "Failed to kill process on port $port."
            return 1
        fi
    }
fi

# Create and open file in Cursor
tcr() {
    if [ -z "$1" ]; then
        echo "Usage: tc <filename>"
        return 1
    fi
    touch "$1" && cursor "$1"
}

# Extract various archive formats
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#====================
# Local Configuration
#====================

# Source local machine-specific configurations if they exist
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
