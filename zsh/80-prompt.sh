__dotfiles_prompt() {
    __dotfiles_pyvenv_ps1  # sets $PYVENVPS1 variable
    __dotfiles_git_ps1  # sets $GITPS1 variable
    if [ "$COLORSUPPORT" -eq 1 ]; then
        PS1='%{%f%}[%(?..%? )%{%F{5}%}$DOTFILESSHELL%{%f%} %{%F{6}%}%*%{%f%}${debian_chroot:+( / $debian_chroot) } : %{%B%F{2%}%n%{%f%b%} @ %{%B%F{4}%}%m%{%f%b%} : %{%B%F{3}%}%~%{%f%b%}'
    else
        PS1='[%(?..%? )$DOTFILESSHELL %*${debian_chroot:+( / $debian_chroot) } : %n @ %m : %~'
    fi
    PS1+="$(eval 'printf -- "%s" "$PYVENVPS1"')"
    PS1+="$(eval 'printf -- "%s" "$GITPS1"')"
    PS1+=$']\n\$ '

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        TERMTITLE='\e]0;${debian_chroot:+($debian_chroot)}$DOTFILESSHELL / %n@%m: %~\a'
        print -Pn "$TERMTITLE"
        ;;
    screen)
        PANETITLE='\e]0;${debian_chroot:+($debian_chroot)}$DOTFILESSHELL: %~\a'
        print -Pn "$PANETITLE"
        ;;
    esac
}

precmd() {
    typeset last_exit_code=$?
    __dotfiles_prompt
    return $last_exit_code
}
