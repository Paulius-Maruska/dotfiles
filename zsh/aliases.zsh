# setup shell aliases
alias reload="typeset -a precmd_functions && precmd_functions=() && source ~/.zshenv && source ~/.zshrc"
alias ll="ls -AlGF"
alias lld="ls -AlGd */(D) "

if [ "$(uname)" = "Darwin" ]; then
    alias pkgup="brew update && brew upgrade"
fi
