if [[ -d $HOME/functions ]]; then
    fpath+=$HOME/functions
    autoload -U $HOME/functions/*(:t)
    _info "found ~/functions directory and added it to \$fpath"
fi
# OS X configuration
if [ "$DOTFILESPLATFORM" = "Darwin" ]; then
    # if we have "zsh-completions" formulae installed - update fpath
    if [ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]; then
        fpath+="$HOMEBREW_PREFIX/share/zsh-completions"
        _info "found \$HOMEBREW_PREFIX/share/zsh-completions directory and added it to \$fpath"
    fi
fi

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY # adds history
setopt COMPLETE_IN_WORD
setopt CORRECT
setopt EXTENDED_GLOB # Treat the '#', '~' and '^' characters as part of patterns
setopt EXTENDED_HISTORY # add timestamps to history
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt IGNORE_EOF
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt PROMPT_SUBST
setopt SHARE_HISTORY # share history between sessions ???

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

zle -N newtab

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[^N' newtab
bindkey '^?' backward-delete-char
