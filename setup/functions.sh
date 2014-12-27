info () {
    printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
    printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

warning () {
    printf "\r\033[2K  [\033[0;33mWARNING\033[0m] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    exit
}

log_name="$DOTFILES_ROOT/setup/install.log"

log_create () {
    if [ -f $log_name ]; then
        fail "dotfiles already installed."
    fi
    echo "Dotfiles setup started: $(date +"%FT%T")">$log_name
}

log_remove () {
    if [ -f $log_name ]; then
        rm -f $log_name
    fi
}

log_installed_link () {
    local dst=$1 src=$2

    if [ -n "$dst" -a -n "$src" ]; then
        echo "l:$dst:$src">>$log_name
    fi
}

log_installed_directory () {
    local dst=$1

    if [ -n "$dst" ]; then
        echo "d:$dst">>$log_name
    fi
}

create_directory () {
    local dst=$1

    local overwrite= backup= skip=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

        if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

            user "File already exists: $dst, what do you want to do?\n\
            [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
            read -n 1 action

            case "$action" in
                o )
                overwrite=true;;
                O )
                overwrite_all=true;;
                b )
                backup=true;;
                B )
                backup_all=true;;
                s )
                skip=true;;
                S )
                skip_all=true;;
                * )
                ;;
            esac

        fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
        rm -rf "$dst"
        success "removed $dst"
    fi

    if [ "$backup" == "true" ]; then
        mv "$dst" "${dst}.backup"
        success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]; then
        success "skipped $dst"
    fi

    if [ "$skip" != "true" ]; then
        mkdir "$dst" && log_installed_directory "$dst"
        success "directory $dst created"
    fi
}

remove_directory () {
    local dst=$1

    local skip=true

    if [ -d "$dst" ]; then

        if [ -z "$(ls -A $dst)" ]; then
            skip=false
        else
            warning "directory $dst is not empty, skipping."
        fi

    fi

    if [ "$skip" != "true" ]; then
        rm -rf $dst
        success "removed $dst"
    fi
}

create_link () {
    local src=$1 dst=$2

    local overwrite= backup= skip=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

        if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

            local currentSrc="$(readlink $dst)"

            if [ "$currentSrc" == "$src" ]; then
                skip=true;
            else

                user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
                [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
                read -n 1 action

                case "$action" in
                    o )
                    overwrite=true;;
                    O )
                    overwrite_all=true;;
                    b )
                    backup=true;;
                    B )
                    backup_all=true;;
                    s )
                    skip=true;;
                    S )
                    skip_all=true;;
                    * )
                    ;;
                esac

            fi

        fi

        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}

        if [ "$overwrite" == "true" ]; then
            rm -rf "$dst"
            success "removed $dst"
        fi

        if [ "$backup" == "true" ]; then
            mv "$dst" "${dst}.backup"
            success "moved $dst to ${dst}.backup"
        fi

        if [ "$skip" == "true" ]; then
            success "skipped $dst"
        fi
    fi

    if [ "$skip" != "true" ]; then
        ln -s "$src" "$dst" && log_installed_link "$dst" "$src"
        success "linked $src to $dst"
    fi
}

remove_link () {
    local src=$1 dst=$2

    local skip=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

        local currentSrc="$(readlink $dst)"

        if [ "$currentSrc" != "$src" ]; then
            skip=true
            warning "link $dst expected to target $src, but the actual target is $currentSrc. Skipping."
        fi
    fi

    if [ "$skip" != "true" ]; then
        rm -f $dst
        success "removed $dst (link to $src)"
    fi
}

install_files () {
    local group_name=$1 dst_dir=$2 file_mask=$3 name_suffix=$4

    local files=$(find "$DOTFILES_ROOT" -maxdepth 2 -name "$file_mask")
    if [ -n "$files" ]; then

        info "installing \033[00;34m$group_name\033[0m\n"

        if [ "$dst_dir" != "$HOME" ]; then
            create_directory "$dst_dir"
        fi

        for src in $files; do
            dst="$dst_dir/$(basename "${src%$name_suffix}")"
            create_link "$src" "$dst"
        done

    else
        info "nothing to install for \033[00;34m$group_name\033[0m\n"
    fi
}

install_brew_packages_osx () {
    info "installing \033[00;34mHomebrew and Homebrew packages\033[0m\n"

    if [ "$(which brew)" = "" ]; then
        info "Homebrew not found, attempting to install"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # these are just the core packages that we want for our shell
    # other things, such as up-to-date git and bash are not here
    local desiredpackages=("coreutils" "zsh" "zsh-completions")
    local missingpackages=()

    for pkg in $desiredpackages; do
        if [ "$(brew ls --versions $pkg)" = "" ]; then
            missingpackages+=$pkg
        fi
    done

    if [ "$missingpackages" != "" ]; then
        brew install $missingpackages
    fi
}

install_packages () {
    local platform="$(uname)"

    if [ "$platform" = "Darwin" ]; then
        install_brew_packages_osx
    fi

    # todo: add other platforms
}

install_dotfiles () {
    info "installing \033[00;34mDotfiles\033[0m\n"

    log_create

    local overwrite_all=true backup_all=false skip_all=false

    install_packages

    install_files "Configurations" "$HOME" "*.home.zsh" ".*.*"

    install_files "Functions" "$HOME/functions" "*.funcs.zsh" ".*.*"

    install_files "Tools" "$HOME/bin" "*.tool.zsh" ".*.*"
}

uninstall_dotfiles () {
    info "uninstalling \033[00;34mDotfiles\033[0m\n"

    local dst= src= t=

    if [ -f $log_name ]; then

        # uninstall links
        for line in $(grep "^l:" $log_name); do
            t=${line#*:}
            dst=${t%:*}
            src=${t#*:}
            remove_link "$src" "$dst"
        done

        # uninstall directories (copied or created)
        for line in $(grep "^d:" $log_name); do
            t=${line#*:}
            dst=$t
            remove_directory "$dst"
        done

        log_remove

    fi
}
