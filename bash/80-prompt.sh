__dotfiles_prompt() {
    typeset last_exit_code=$?
    typeset last_cmd_status=""

    if [ "$last_exit_code" != "0" ]; then
        last_cmd_status="$last_exit_code "
    fi

    __dotfiles_git_ps1  # sets $GITPS1 variable
    if [ "$COLORSUPPORT" -eq 1 ]; then
        PS1='\[\033[0m\]['
        PS1+="$last_cmd_status"
        PS1+='\[\033[35m\]$DOTFILESSHELL\[\033[0m\] \[\033[1;33m\]\t\[\033[0m\]${debian_chroot:+( / $debian_chroot) } : \[\033[1;32m\]\u\[\033[0m\] @ \[\033[1;34m\]\h\[\033[0m\] : \[\033[1;33m\]\w\[\033[0m\]'
    else
        PS1='['
        PS1+="$last_cmd_status"
        PS1+='$DOTFILESSHELL \t${debian_chroot:+( / $debian_chroot) } : \u @ \h : \w'
    fi
    PS1+="$(eval 'printf -- "%s" "$GITPS1"')"
    PS1+=']\n\$ '

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\033]0;${debian_chroot:+($debian_chroot)}$DOTFILESSHELL / \u@\h : \w\a\]$PS1"
        ;;
    esac

    return $last_exit_code
}
PROMPT_COMMAND='__dotfiles_prompt'
