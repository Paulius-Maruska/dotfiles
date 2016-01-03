#!/bin/sh
DOTFILES=$HOME/.dotfiles
DOTFILESDEBUG=1

source $DOTFILES/setup/_lib/load.sh

for filename in $(install_list_files_link); do
    if [ -f "$filename" ]; then
        debug "linking $(basename "$DOTFILES")/${filename#$DOTFILES/} to ~/$(basename -s .link $filename)"
        ln -s $filename $HOME/$(basename -s .link $filename)
        info "linked $(basename "$DOTFILES")/${filename#$DOTFILES/} to ~/$(basename -s .link $filename)"
    fi
done

if [ ! -d "$HOME/bin" ]; then
    mkdir "$HOME/bin"
fi
for filename in $(install_list_files_script); do
    if [ -f "$filename" ]; then
        debug "linking $(basename "$DOTFILES")/${filename#$DOTFILES/} to ~/bin/$(basename -s .link $filename)"
        ln -s $filename $HOME/bin/$(basename -s .link $filename)
        info "linked $(basename "$DOTFILES")/${filename#$DOTFILES/} to ~/bin/$(basename -s .link $filename)"
    fi
done

source $DOTFILES/setup/_lib/unload.sh
