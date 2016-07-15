export DOTFILESPLATFORM="$(uname -s)"

if [ "$DOTFILESPLATFORM" = "Darwin" ]; then
    # set HOMEBREW_PREFIX path (default is /usr/local)
    export HOMEBREW_PREFIX="$(brew --prefix)"

    # move $(brew --prefix)/bin to the front of $PATH
    export PATH="$HOMEBREW_PREFIX/bin:$PATH"

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

if [ "$TERM" = "xterm" -a "$COLORTERM" = "gnome-terminal" ]; then
    # Gnome terminal reports itself as "xterm" although it supports
    # all 256 colors and more.
    export TERM="xterm-256color"
fi

if [ -t 1 -a "$(tput colors)" -ge 8 ]; then
    export COLORSUPPORT=1
else
    export COLORSUPPORT=0
fi

export EDITOR=vim
