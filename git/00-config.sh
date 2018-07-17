if [ "$DOTFILESPLATFORM" = "Darwin" ]; then
    _info "loading git completions for Darwin"
    if [ "$DOTFILESSHELL" = "bash" ]; then
        source $HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash
    fi
    if [ "$DOTFILESSHELL" = "zsh" ]; then
        fpath+="$HOMEBREW_PREFIX/opt/git/share/zsh/site-functions"
    fi
fi
