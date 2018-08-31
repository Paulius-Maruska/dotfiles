__list_files_to_source_internal(){
    local filter=
    local output="-printf '%f:%p\n'"
    local evalstr=""

    # Files from env first (these are supposed to setup env variables)
    filter="-name '*.sh'"
    evalstr+="find -H $DOTFILES/env $filter $output;"

    # Files from $DOTFILESSHELL second
    filter="-name '*.sh'"
    evalstr+="find -H $DOTFILES/$DOTFILESSHELL $filter $output;"

    # Everything else
    filter="-mindepth 2 "
    filter+="-not -path '*/.git/*' "
    filter+="-not -path '*/_dotfiles/*' "
    filter+="-not -path '*/setup/*' "
    filter+="-not -path '*/env/*' "
    filter+="-not -path '*/zsh/*' "
    filter+="-not -path '*/bash/*' "
    filter+="-name '*.sh' "
    evalstr+="find -H $DOTFILES $filter $output;"

    eval "$evalstr" | sort -s -t : -k 1.1,1.3

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
