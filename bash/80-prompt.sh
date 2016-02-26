__dotfiles_prompt() {
    typeset last_exit_code=$?
    typeset last_cmd_status=""

    if [ "$last_exit_code" != "0" ]; then
        last_cmd_status="$last_exit_code "
    fi

    __dotfiles_pyvenv_ps1  # sets $PYVENVPS1 variable
    __dotfiles_git_ps1  # sets $GITPS1 variable
    if [ "$COLORSUPPORT" -eq 1 ]; then
        PS1='\[\e[0m\]['
        PS1+="$last_cmd_status"
        PS1+='\[\e[35m\]$DOTFILESSHELL\[\e[0m\] \[\e[36m\]\t\[\e[0m\]${debian_chroot:+( / $debian_chroot) } : \[\e[1;32m\]\u\[\e[0m\] @ \[\e[1;34m\]\h\[\e[0m\] : \[\e[1;33m\]\w\[\e[0m\]'
    else
        PS1='['
        PS1+="$last_cmd_status"
        PS1+='$DOTFILESSHELL \t${debian_chroot:+( / $debian_chroot) } : \u @ \h : \w'
    fi
    PS1+="$(eval 'printf -- "%s" "$PYVENVPS1"')"
    PS1+="$(eval 'printf -- "%s" "$GITPS1"')"
    PS1+=']\n\$ '

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        TERMTITLE='\[\e]0;${debian_chroot:+($debian_chroot)}$DOTFILESSHELL / \u@\h : \w\a\]'
        PS1="${TERMTITLE}${PS1}"
        ;;
    screen)
        PANETITLE='\[\e]0;${debian_chroot:+($debian_chroot)}$DOTFILESSHELL: \w\a\]'
        PS1="${PANETITLE}${PS1}"
        ;;
    esac

    return $last_exit_code
}
PROMPT_COMMAND='__dotfiles_prompt'
