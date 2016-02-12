__list_files_to_source_internal(){
    local filter=
    local output="-printf '%f:%p\n'"

    # Files from env first (these are supposed to setup env variables)
    filter="-name '*.sh'"
    eval "find -H $DOTFILES/env $filter $output" | sort

    # Files from $DOTFILESSHELL second
    filter="-name '*.sh'"
    eval "find -H $DOTFILES/$DOTFILESSHELL $filter $output" | sort

    # Everything else
    filter="-mindepth 2"
    filter="$filter -not -path '*.git*'"
    filter="$filter -not -path '*_dotfiles*'"
    filter="$filter -not -path '*setup*'"
    filter="$filter -not -path '*env*'"
    filter="$filter -not -path '*zsh*'"
    filter="$filter -not -path '*bash*'"
    filter="$filter -name '*.sh'"
    eval "find -H $DOTFILES $filter $output" | sort

    # Lastly load the private file (it will be ignored, if it doesn't exist)
    # Note: the same file is used for all shells.
    echo ".localrc:$HOME/.localrc"
}

__list_files_to_link_internal(){
    local target_dir="$1"
    local filter=
    local output="-printf '%f:%p\n'"

    # Configurations to be linked in $HOME
    filter="-name '*.link'"
    eval "find -H $DOTFILES $filter $output"

    # Configurations to be linked in $HOME/bin
    filter="-perm -g=x"
    filter="$filter -type f"
    filter="$filter -not -path '*.git*'"
    filter="$filter -not -path '*_dotfiles*'"
    filter="$filter -not -path '*setup*'"
    filter="$filter -name '*.script'"
    eval "find -H $DOTFILES $filter $output"
}

list_files_to_source(){
    for line in $(__list_files_to_source_internal); do
        echo "${line##*:}"  # strip <filename>: from the start of the every line
    done
}

list_files_to_link(){
    local target_dir="$1"
    local filter=
    local output="-printf '%f:%p\n'"

    # Configurations to be linked in $HOME
    filter="-name '*.link'"
    for line in $(__list_files_to_link_internal); do
        fn="${line%%:*}"
        fp="${line##*:}"

        case "$fn" in
            *.link)
                lt="$target_dir/$bn" ;;
            *.script)
                lt="$target_dir/bin/$bn" ;;
            *)
                lt="" ;;
        esac
        if [ -n "$lt" ]; then
            echo "$lt:$fp"
        fi
    done
}
