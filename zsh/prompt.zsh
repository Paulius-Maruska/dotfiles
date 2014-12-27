autoload colors && colors

# this is my way of implementing prompt "themes"

output_prompt_value () {
    local val=$1
    local prefix="${fg_bold[white]}[${reset_color}"
    local suffix="${fg_bold[white]}]${reset_color}"
    print -Pn "$prefix $val $suffix"
}

current_os_version () {
    local oss="${fg_bold[yellow]}$(uname)"
    local ver="${fg_bold[green]}v$(uname -r)"
    output_prompt_value "${oss} ${ver}${reset_color}"
}

current_timestamp () {
    local tsd="${fg_bold[yellow]}$(date +"%F")"
    local tst="${fg_bold[green]}$(date +"%T")"
    output_prompt_value "${tsd} ${tst}${reset_color}"
}

current_directory () {
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Shell-state
    # %/ - full path of current directory
    # %~ - current path, replacing $HOME with ~
    output_prompt_value "${fg_bold[yellow]}%~${reset_color}"
}

current_user_and_hostname () {
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Login-information
    # %n - expands to current user name
    # %m - expands to computer hostname (up to the first '.' character)
    local usr="${fg[magenta]}%n"
    local hst="${fg_bold[green]}%m"
    local sep="${fg_bold[white]}@"
    output_prompt_value "${usr} ${sep} ${hst}${reset_color}"
}

zsh_precmd () {
    local line="$(current_os_version)$(current_timestamp)$(current_user_and_hostname)$(current_directory)"
    echo $line
    title
}

typeset -a precmd_functions
precmd_functions+="zsh_precmd"

PROMPT="%{${fg_bold[white]}%}%#>%{$reset_color%} "
