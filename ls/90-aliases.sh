# some more ls aliases
if [ "$COLORSUPPORT" -eq 1 ]; then
    alias ls='ls --color=auto'
fi
alias ll='ls -alF --group-directories-first'
alias la='ls -A'
alias l='ls -CF'
