# enable color support of ls
if [ "$COLORSUPPORT" -eq 1 ]; then
    if [ -r "$HOME/.dircolors" ]; then
        eval "$(dircolors -b $HOME/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    info "loaded \$(dircolors -b)"
fi
