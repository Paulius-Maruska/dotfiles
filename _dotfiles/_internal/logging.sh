LOGGING_ENABLED=1
LOGGING_COLORS=1

_dotfiles_log_msg(){
    typeset shellname="$DOTFILESSHELL"
    typeset timestamp="$(date '+%H:%M:%S')"
    typeset level="$1"
    typeset message="$2"
    typeset sep="-"

    typeset fmt="%4b %b %b %5b %b %s\n"
    if [ "$LOGGING_COLORS" -eq 1 ]; then
        shellname="\033[0;35m$shellname\033[0m"
        timestamp="\033[36m$timestamp\033[0m"
        if [ "$level" = "debug" ]; then
            level="\033[1;32m$level\033[0m"
        elif [ "$level" = "info" ]; then
            level="\033[0;34m$level\033[0m"
        elif [ "$level" = "warn" ]; then
            level="\033[0;33m$level\033[0m"
        elif [ "$level" = "error" ]; then
            level="\033[0;31m$level\033[0m"
        else
            level="\033[0;35m$level\033[0m"
        fi
        sep="\033[37m$sep\033[0m"
    fi
    if [ "$LOGGING_ENABLED" -eq 1 ]; then
        printf "$fmt" "$shellname" "$timestamp" "$sep" "$level" "$sep" "$message"
    fi
}

alias _debug='_dotfiles_log_msg debug'
alias _info='_dotfiles_log_msg info'
alias _warn='_dotfiles_log_msg warn'
alias _error='_dotfiles_log_msg error'
