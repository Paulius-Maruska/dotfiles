PYTHON_VENV_COLOR="$COLORSUPPORT"

__python_venv_ps1() {
    local format="$1"
    local venv

    local c_red=''
    local c_green=''
    local c_yellow=''
    local c_blue=''
    local c_clear=''

    if [ "$PYTHON_VENV_COLOR" -eq 1 ]; then
        if [[ "$DOTFILESSHELL" = "bash" ]]; then
            c_red='\[\e[31m\]'
            c_green='\[\e[32m\]'
            c_yellow='\[\e[33m\]'
            c_blue='\[\e[34m\]'
            c_clear='\[\e[0m\]'
        elif [[ "$DOTFILESSHELL" = "zsh" ]]; then
            c_red='%{%F{red}%}'
            c_green='%{%F{green}%}'
            c_yellow='%{%F{yellow}%}'
            c_blue='%{%F{blue}%}'
            c_clear='%{%f%}'
        fi
    fi

    if [ -n "$VIRTUAL_ENV" ]; then
        tilde='~'
        venv="$(readlink -f "$VIRTUAL_ENV")"
        venv_home="${venv/$HOME/$tilde}"
        venv_pwd="${venv/$PWD/.}"
        if [ -f "$venv/pyvenv.cfg" ]; then
            while read name sep value; do
                case "$name" in
                    # home) venv_home="$value" ;;
                    # include-system-site-packages) venv_syspacks="$value" ;;
                    version) venv_version="$value" ;;
                esac
            done < "$venv/pyvenv.cfg"
        fi

        venv="$venv_home"
        if [ ${#venv_home} -gt ${#venv_pwd} ]; then
            venv="$venv_pwd"
        fi

        venv_ps1="${c_yellow}$venv${c_clear}"
        if [ -n "$venv_version" ]; then
            venv_ps1="${c_blue}$venv_version${c_clear} ${c_yellow}$venv${c_clear}"
        fi
        export PYVENVPS1="$(printf -- "$format" "$venv_ps1")"
    else
        export PYVENVPS1=""
    fi
}

__dotfiles_pyvenv_ps1(){
  typeset ret=$?
  __python_venv_ps1 " : %s"
  return $ret
}
