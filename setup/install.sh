#!/usr/bin/env bash
DOTFILES=$HOME/.dotfiles
DOTFILESDEBUG=1

source $DOTFILES/_dotfiles/lib.sh

_info "installing dotfiles"
for line in $(list_files_to_link); do
    targetname="${line##*:}"
    linkname="${line%%:*}"
    if [ -f "$targetname" ]; then
        _info "creating link '$linkname' => '$targetname'"
        linkdir="$(dirname "$linkname")"
        if [ ! -d "$linkdir" ]; then
            mkdir -p "$linkdir"
        fi
        if [ ! -e "$linkname" ]; then
            ln -s "$targetname" "$linkname"
            if [ "$?" -ne 0 ]; then
                exit 1
            fi
            _debug "link created '$linkname' => '$targetname'"
        else
            linksto="$(readlink -f "$linkname")"
            if [ "$linksto" != "$targetname" ]; then
                _warn "file '$linkname' already exists, skipping link creation"
            else
                _debug "link already exists '$linkname' => '$targetname'"
            fi
        fi
    fi
done
_debug "dotfiles installed"
