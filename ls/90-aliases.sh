# some more ls aliases
if [ "$COLORSUPPORT" -eq 1 ]; then
    alias ls='ls --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
