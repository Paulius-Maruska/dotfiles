# loader.sh should be source from either .zshrc or .bashrc
DOTFILESDEBUG=1

source $DOTFILES/setup/_lib/load.sh

for filename in $(loader_list_files_in_correct_order); do
    if [ -f "$filename" ]; then
        _debug "$(basename "$DOTFILES")/${filename#$DOTFILES/} - loading"
        source $filename
        _info "$(basename "$DOTFILES")/${filename#$DOTFILES/} - loaded"
    fi
done

source $DOTFILES/setup/_lib/unload.sh
