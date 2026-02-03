# path
export PATH="$HOME/.local/bin:$PATH"

# Node (for non-interactive shells like nvim plugin builds)
export PATH="$HOME/.config/nvm/versions/node/v22.16.0/bin:$PATH"

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=5000                     # Maximum events for internal history
export SAVEHIST=10000                    # Maximum events in history file

