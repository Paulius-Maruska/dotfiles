# setup shell aliases
alias reload="typeset -a precmd_functions && precmd_functions=() && source ~/.zshenv && source ~/.zshrc"
alias ll="ls -AlGF"
alias bu="brew update && brew upgrade"
