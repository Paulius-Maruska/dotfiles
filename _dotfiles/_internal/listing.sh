__transform_input(){
    while read line; do
        if [[ -z "$line" ]]; then
            return 0
        fi
        echo "$(basename "$line"):$line"
    done
}
__list_files_to_source_internal(){
    # Files from env first (these are supposed to setup env variables)
    find "$DOTFILES/env" -name "*.sh" -print | __transform_input | sort -s -t : -k 1.1,1.3

    # Files from $DOTFILESSHELL second
    find "$DOTFILES/$DOTFILESSHELL" -name "*.sh" -print | __transform_input | sort -s -t : -k 1.1,1.3

    # Everything else
    local dirstoskip=( ".git" "_dotfiles" "setup" "env" "zsh" "bash" )
    local args=( )
    for d in "${dirstoskip[@]}"; do
        args=(
            "${args[@]}"
            ! -path "*/$d/*"
        )
    done
    find -f "$DOTFILES" "${args[@]}" -mindepth 2 -name "*.sh" -print | __transform_input | sort -s -t : -k 1.1,1.3

    # Lastly load the private file (it will be ignored, if it doesn't exist)
    # Note: the same file is used for all shells.
    echo ".localrc:$HOME/.localrc"
}

__list_files_to_link_internal(){
    # Configurations to be linked in $HOME
    eval "find -H $DOTFILES -name '*.link' -printf '%p\n'" | sort -s -t : -k 1.1,1.3
}

list_files_to_source(){
    for line in $(__list_files_to_source_internal); do
        echo "${line##*:}"  # strip <filename>: from the start of the every line
    done
}

list_files_to_link(){
    local output="-printf '%f:%p\n'"

    # Configurations to be linked in $HOME
    for line in $(__list_files_to_link_internal); do
        ditfiles_path="${line##$DOTFILES/}"
        home_path="$HOME/${ditfiles_path#*/}"
        link_path="${home_path%.link}"
        echo "$link_path:$line"
    done
}
