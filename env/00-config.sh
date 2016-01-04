export DOTFILESPLATFORM="$(uname -s)"
_info "platform is $DOTFILESPLATFORM"

if [ "$DOTFILESPLATFORM" = "Darwin" ]; then
    # set HOMEBREW_PREFIX path (default is /usr/local)
    export HOMEBREW_PREFIX="$(brew --prefix)"
    _info "prefix for Homebrew is $HOMEBREW_PREFIX"

    COREUTILS_PREFIX="$(brew --prefix coreutils)"
    _info "prefix for coreutils is $COREUTILS_PREFIX"

    if [ -n "$COREUTILS_PREFIX" ]; then
        # if coreutils are installed, add them to start of $PATH and $MANPATH
        export PATH="$COREUTILS_PREFIX/libexec/gnubin:$(printf '%s\n' "$PATH"|sed -e "s@$COREUTILS_PREFIX/libexec/gnubin:@@g;s/::/:/g")"
        export MANPATH="$COREUTILS_PREFIX/libexec/gnuman:$(printf '%s\n' "$MANPATH"|sed -e "s@$COREUTILS_PREFIX/libexec/gnuman:@@g;s/::/:/g")"
    fi

    # move $(brew --prefix)/bin to the front of $PATH
    export PATH="$HOMEBREW_PREFIX/bin:$(printf '%s\n' "$PATH"|sed -e "s@$HOMEBREW_PREFIX/bin:@@g;s/::/:/g")"
fi

# add ~/bin to PATH (if one exists)
if [ -d "$HOME/bin" ]; then
    # move home_bin if it was found
    export PATH="$HOME/bin:$(printf '%s\n' "$PATH"|sed -e "s@$HOME/bin:@@g;s/::/:/g")"
    _info "found ~/bin directory and added it to \$PATH"
fi

if [ -t 1 -a "$(tput colors)" -ge 8 ]; then
    export COLORSUPPORT=1
    _info "colors are supported"
else
    export COLORSUPPORT=0
    _info "colors are NOT supported"
fi
