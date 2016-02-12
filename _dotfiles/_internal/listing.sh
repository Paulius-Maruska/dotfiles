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

list_files_to_source(){
    for fn in $(__list_files_to_source_internal); do
        echo "${fn##*:}"  # strip <filename>: from the start of the every line
    done
}
