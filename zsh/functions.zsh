# some useful logging functions
_log_lvls=("\033[00;32mdebug\033[0m" "\033[00;34minfo\033[0m" "\033[00;33mwarning\033[0m" "\033[00;31merror\033[0m")
log_lvl_str () {
    local lvl=$1 msg=$2
    printf "[ %-7b ] %b\n" "${_log_lvls[$lvl]}" "$msg"
}
log_debug () { log_lvl_str 1 "$1" }
log_info () { log_lvl_str 2 "$1" }
log_warning () { log_lvl_str 3 "$1" }
log_error () { log_lvl_str 4 "$1" }

# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
# first argument is the title string, if it is omitted - default title
# is used (default: "user @ host: ~path").
function title() {
    local title="%n @ %m: %~"

    if [ "$1" != "" ]; then
        # escape '%' chars in $1, make nonprintables visible
        title=${(V)1//\%/\%\%}
    fi
    # truncate command, and join lines.
    title=$(print -Pn "%40>...>$title" | tr -d "\n")

    case $TERM in
        screen)
            print -Pn "\ek$title\e\\"
        ;;
        xterm*|rxvt)
            print -Pn "\e]0;$title\a"
        ;;
    esac
}
