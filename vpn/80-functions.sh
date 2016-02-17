initvpn(){
    typeset ovpnname=$1
    if [ -f "$HOME/.ovpn/$ovpnname.ovpn" ]; then
        ovpnname="$HOME/.ovpn/$ovpnname.ovpn"
    elif [ -f "$HOME/.ovpn/$ovpnname" ]; then
        ovpnname="$HOME/.ovpn/$ovpnname"
    elif [ ! -f "$ovpnname" ]; then
        echo "Error: could not find '$ovpnname' file." 1>&2
        return 1
    fi
    echo "sudo openvpn --config '$ovpnname' --daemon" | sh
}

checkvpn(){
    typeset ovpnname=$1
    if [ -f "$HOME/.ovpn/$ovpnname.ovpn" ]; then
        ovpnname="$HOME/.ovpn/$ovpnname.ovpn"
    elif [ -f "$HOME/.ovpn/$ovpnname" ]; then
        ovpnname="$HOME/.ovpn/$ovpnname"
    elif [ ! -f "$ovpnname" ]; then
        echo "Error: could not find '$ovpnname' file." 1>&2
        return 1
    fi
    ps -eo pid,cmd | grep -v "grep" | grep "$ovpnname"
}

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
