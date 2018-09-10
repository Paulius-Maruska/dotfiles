if [ "$DOTFILESSHELL" = "bash" -a -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
fi
if [ "$DOTFILESSHELL" = "zsh" -a -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi
