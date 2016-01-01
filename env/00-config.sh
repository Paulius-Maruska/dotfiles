export DOTFILESPLATFORM=$(uname -s)

if [ "$DOTFILESPLATFORM" = "Darwin" ]; then
    # set HOMEBREW_PREFIX path (default is /usr/local)
    export HOMEBREW_PREFIX="$(brew --prefix)"

    if [ -n "$(brew --prefix coreutils)" ]; then
        # if coreutils are installed, add them to start of path
        export PATH="$(brew --prefix coreutils)/libexec/gnubin:$(printf '%s\n' "$PATH"|sed -e "s@$(brew --prefix coreutils)/libexec/gnubin:@@g;s/::/:/g")"
        export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$(printf '%s\n' "$MANPATH"|sed -e "s@$(brew --prefix coreutils)/libexec/gnuman:@@g;s/::/:/g")"
    fi

    # move $(brew --prefix)/bin to the front of $path (so newer brew installed apps are
    # found first, before the old stuff that apple distributes by default)
    export PATH="$HOMEBREW_PREFIX/bin:$(printf '%s\n' "$PATH"|sed -e "s@$HOMEBREW_PREFIX/bin:@@g;s/::/:/g")"
fi

# add ~/bin to PATH (if one exists)
if [ -d "$HOME/bin" ]; then
    home_bin="$HOME/bin"

    # move home_bin if it was found
    export PATH="$HOME/bin:$(printf '%s\n' "$PATH"|sed -e "s@$HOME/bin:@@g;s/::/:/g")"
fi
