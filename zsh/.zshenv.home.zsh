# this is intended to set some important environment variables, such as root
# directory for Dotfiles and projects, update PATH etc.

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES=$HOME/.dotfiles

# your project folder that we can `c [tab]` to
export PROJECTS=$HOME/Projects

# add ~/bin to PATH (if one exists)
if [ -d "$HOME/bin" ]; then
    # check if ~/bin is already in path (this happens when reloading)
    if [ "${PATH#*$HOME/bin}" = "$PATH" ]; then
        export PATH=$PATH:$HOME/bin
    fi
fi

# OS X configuration
if [ "$(uname)" = "Darwin" ]; then
    # set HOMEBREW_PREFIX path (default is /usr/local)
    export HOMEBREW_PREFIX="$(brew --prefix)"

    # if we have "zsh-completions" formulae installed - update fpath
    if [ -d "$HOMEBREW_PREFIX/share/zsh-completions" ]; then
        fpath+="$HOMEBREW_PREFIX/share/zsh-completions"
    fi
fi

# add ~/functions to fpath, if it exists
if [ -d "$HOME/functions" ]; then
    fpath+="$HOME/functions"
fi
