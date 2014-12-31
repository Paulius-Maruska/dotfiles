# load zsh/functions.zsh, because we are going to use those functions
source $DOTFILES/zsh/functions.zsh

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]; then
    log_debug "loading ~/.localrc"
    source ~/.localrc
fi

# all of our zsh/*.zsh files
typeset -U zfiles
zfiles=($DOTFILES/**/zsh/*.zsh(D))
# filter out all the special files and already loaded files
zfiles=(${zfiles:#*.home.zsh})
zfiles=(${zfiles:#*.funcs.zsh})
zfiles=(${zfiles:#*.tool.zsh})
zfiles=(${zfiles:#*/zsh/functions.zsh})

# load everything but the completion files
for file in ${zfiles:#*/completion.zsh}; do
    log_debug "loading $file"
    source $file
done

# all of our zsh files
typeset -U files
files=($DOTFILES/**/*.zsh(D))

# filter out all the special files and already loaded files
files=(${files:#**/zsh/**})
files=(${files:#*.home.zsh})
files=(${files:#*.funcs.zsh})
files=(${files:#*.tool.zsh})

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

# load zsh completion after autocomplete loads
for file in ${(M)zfiles:#*/completion.zsh}; do
    log_debug "loading $file"
    source $file
done

# load every completion after autocomplete loads
for file in ${(M)files:#*/completion.zsh}; do
    log_debug "loading $file"
    source $file
done

unset zfiles
unset files
