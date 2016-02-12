# loader.sh should be source from either .zshrc or .bashrc
DOTFILESDEBUG=1

source $DOTFILES/_dotfiles/lib.sh
_info "loading shell configuration for $DOTFILESSHELL"

for filename in $(list_files_to_source); do
    if [ -f "$filename" ]; then
        _info "sourcing file '$(basename "$DOTFILES")/${filename#$DOTFILES/}'"
        source $filename
        _debug "file '$(basename "$DOTFILES")/${filename#$DOTFILES/}' sourced"
    fi
done

source $DOTFILES/_dotfiles/unlib.sh
