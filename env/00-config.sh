export DOTFILESPLATFORM="$(uname -s)"

if [ "$DOTFILESPLATFORM" = "Darwin" ]; then
    COREUTILS_PREFIX="$(brew --prefix coreutils)"
    if [ -n "$COREUTILS_PREFIX" ]; then
        # if coreutils are installed, add them to start of $PATH and $MANPATH
        export PATH="$COREUTILS_PREFIX/libexec/gnubin:$(printf '%s\n' "$PATH"|sed -e "s@$COREUTILS_PREFIX/libexec/gnubin:@@g;s/::/:/g")"
        export MANPATH="$COREUTILS_PREFIX/libexec/gnuman:$(printf '%s\n' "$MANPATH"|sed -e "s@$COREUTILS_PREFIX/libexec/gnuman:@@g;s/::/:/g")"
    fi
fi

# add ~/bin to PATH (if one exists)
if [ -d "$HOME/bin" ]; then
    # move home_bin if it was found
    export PATH="$HOME/bin:$(printf '%s\n' "$PATH"|sed -e "s@$HOME/bin:@@g;s/::/:/g")"
fi

if [ -t 1 -a "$(tput colors)" -ge 8 ]; then
    export COLORSUPPORT=1
else
    export COLORSUPPORT=0
fi

export EDITOR=vim

if [ "${#UPDATE_COMMANDS[@]}" = "0" ]; then
    export UPDATE_COMMANDS=()
    UPDATE_COMMANDS+=(
        "(cd "${DOTFILES}" && git pull)"
    )
fi
