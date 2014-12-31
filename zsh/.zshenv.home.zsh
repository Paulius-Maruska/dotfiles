# this is intended to set some important environment variables, such as root
# directory for Dotfiles and projects, update PATH etc.

# shortcut to this dotfiles path is $DOTFILES
export DOTFILES=$HOME/.dotfiles

# your project folder that we can `c [tab]` to
export PROJECTS=$HOME/Projects

# move $(brew --prefix)/bin to the front of $path (so newer brew installed apps are
# found first, before the old stuff that apple distributes by default)
if [ "$(uname)" = "Darwin" ]; then
    brew_prefix="$(brew --prefix)"
    brew_bin="${brew_prefix}/bin"
    brew_bin_index=${path[(i)${brew_bin}]}

    # remove brew_bin if it was found
    if [ "$brew_bin_index" -le "${#path}" ]; then
        path[$brew_bin_index]=()
    fi

    path=("$brew_bin" "${path[@]}")
fi

# add ~/bin to PATH (if one exists)
if [ -d "$HOME/bin" ]; then
    home_bin="$HOME/bin"
    home_bin_index=${path[(i)${home_bin}]}

    # if home_bin isn't already in path, add it (to the front)
    if [ "$home_bin_index" -gt "${#path}" ]; then
        path=("$home_bin" "${path[@]}")
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
