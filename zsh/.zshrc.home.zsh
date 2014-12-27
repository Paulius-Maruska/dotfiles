# load zsh/functions.zsh, because we are going to use those functions
source $DOTFILES/zsh/functions.zsh

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]; then
    log_debug "loading ~/.localrc"
    source ~/.localrc
fi

# all of our zsh files
typeset -U files
files=($DOTFILES/**/*.zsh $DOTFILES/**/*.zsh)

# filter out all the special files
files=(${files:#*.home.zsh})
files=(${files:#*.funcs.zsh})
files=(${files:#*.tool.zsh})
files=(${files:#zsh/functions.zsh})

# load the path files
for file in ${(M)files:#*/path.zsh}; do
    log_debug "loading $file"
    source $file
done
files=(${files:#*/path.zsh})

# load everything but the path and completion files
for file in ${files:#*/completion.zsh}; do
    log_debug "loading $file"
    source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)files:#*/completion.zsh}; do
    log_debug "loading $file"
    source $file
done

unset files
