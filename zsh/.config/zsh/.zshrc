#PLUGINS
fpath+=($ZDOTDIR/plugins/pure)

#HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file
setopt HIST_NO_STORE             # Don't store history commands
setopt HIST_REDUCE_BLANKS        # Remove extra blanks from history lines

#NAVIGATION & EFFICIENCY
setopt AUTO_CD                    # cd by typing directory name
setopt AUTO_PUSHD                 # Push old directory onto stack
setopt PUSHD_IGNORE_DUPS          # Don't push duplicates
setopt PUSHD_SILENT               # Don't print directory stack
setopt EXTENDED_GLOB              # Enable extended globbing
setopt GLOB_DOTS                  # Include dotfiles in globs

#ERROR HANDLING
setopt CORRECT                    # Suggest corrections for commands

#PROMPT
autoload -U promptinit; promptinit
# optionally define some options
PURE_CMD_MAX_EXEC_TIME=10
# change the path color
zstyle :prompt:pure:path color white
# change the color for both `prompt:success` and `prompt:error`
zstyle ':prompt:pure:prompt:*' color cyan
# turn on git stash status
zstyle :prompt:pure:git:stash show yes
prompt pure

#COMPLETION
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}      # Colorized completion
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#ALIAS
alias vps='ssh ubuntu@139.99.61.129'

export PATH='/home/riley/.config/nvm/versions/node/v22.16.0/bin':$PATH
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

eval "$(uv generate-shell-completion zsh)"
export PATH="$HOME/.local/bin:$PATH"
