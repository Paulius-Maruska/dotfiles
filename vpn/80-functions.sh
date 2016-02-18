__list_ovpns() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=()
    for ovpnname in $(ls $HOME/.ovpn/$cur*.ovpn); do
        name="$(basename "$ovpnname")"
        COMPREPLY+=("${name%%.ovpn}")
    done
    return 0
}

# autocompletion for bash
complete -F __list_ovpns initvpn
complete -F __list_ovpns checkvpn
