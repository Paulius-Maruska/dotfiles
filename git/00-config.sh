if [ "$DOTFILESPLATFORM" = "Darwin" ]; then
    info "loading git completions for Darwin"
    if [ "$DOTFILESSHELL" = "bash" ]; then
        source $HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash
        info "loaded \$HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash"
    fi
    if [ "$DOTFILESSHELL" = "zsh" ]; then
        fpath+="$HOMEBREW_PREFIX/opt/git/share/zsh/site-functions"
        info "added \$HOMEBREW_PREFIX/opt/git/share/zsh/site-functions to \$fpath"
    fi
fi
