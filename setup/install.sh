#!/bin/sh
DOTFILES=$HOME/.dotfiles
DOTFILESDEBUG=1

source $DOTFILES/_dotfiles/lib.sh

_info "installing dotfiles"
for line in $(list_files_to_link_in_root "$HOME"); do
    filename="${line##*:}"
    linkname="${line%%:*}"
    if [ -f "$filename" ]; then
        _info "linking file '${filename}' to '$linkname'"
        if [ ! -h "$linkname" ]; then
            ln -s "$filename" "$linkname"
            if [ "$?" -ne 0 ]; then
                exit 1
            fi
        fi
        _debug "file linked '${filename}' to '$linkname'"
    fi
done
_debug "dofiles installed"

source $DOTFILES/_dotfiles/unlib.sh
