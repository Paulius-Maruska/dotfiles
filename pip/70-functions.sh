if [ "$DOTFILESSHELL" = "bash" ]; then
  eval "$(pip completion -b)"
fi
if [ "$DOTFILESSHELL" = "zsh" ]; then
  eval "$(pip completion -z)"
fi
