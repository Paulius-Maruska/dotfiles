LOGGING_COLORS=1

_dotfiles_log_msg(){
    typeset timestamp="$(date '+%H:%M:%S')"
    typeset level="$1"
    typeset message="$2"
    typeset cr="\033[0m"
    typeset csh="\033[0;35m"
    typeset csym="\033[37m"
    typeset cts="\033[36m"
    typeset clvl="\033[0;35m"  # default/unknown level
    typeset cmsg="$cr"
    typeset fmt="%4s %s - %5s - %s\n"
    if [ "$LOGGING_COLORS" -eq 1 ]; then
        if [ "$level" = "debug" ]; then
            clvl="\033[1;32m"
        elif [ "$level" = "info" ]; then
            clvl="\033[0;34m"
        elif [ "$level" = "warn" ]; then
            clvl="\033[0;33m"
        elif [ "$level" = "error" ]; then
            clvl="\033[0;31m"
        else
            clvl="\033[0;35m"
        fi
        fmt="$csh%4s$cr $cts%s$cr $csym-$cr $clvl%5s$cr $csym-$cr $cmsg%s$cr\n"
    fi
    printf "$fmt" "$DOTFILESSHELL" "$timestamp" "$level" "$message"
}

alias _debug='_dotfiles_log_msg debug'
alias _info='_dotfiles_log_msg info'
alias _warn='_dotfiles_log_msg warn'
alias _error='_dotfiles_log_msg error'
