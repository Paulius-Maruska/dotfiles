# loader.sh should be source from either .zshrc or .bashrc
DOTFILESDEBUG=1
loader_report(){
    if [ "$DOTFILESDEBUG" -eq 1 ]; then
        local action=$1
        local filename=$2
        printf "\033[37m[ \033[34m$action \033[37m]\033[0m $filename\n"
    fi
}

# Load the files from env first (these are supposed to setup env variables)
findopts=-H $DOTFILES/env \
    -name '*.sh'

for filename in $(find $findopts|sort); do
    loader_report "Loading" $filename
    source $filename
done

# Load the files from $DOTFILESSHELL second
findopts=-H $DOTFILES/$DOTFILESSHELL \
    -name '*.sh'

for filename in $(find $findopts|sort); do
    loader_report "Loading" $filename
    source $filename
done

# Load the *.sh files from the rest of directories
findopts=-H $DOTFILES \
    -name '*.sh' \
    -mindepth 2\
    -not -path '*.git*' \
    -not -path '*setup*' \
    -not -path '*env*' \
    -not -path '*zsh*' \
    -not -path '*bash*'

for filename in $(find $findopts|sort); do
    loader_report "Loading" $filename
    source $filename
done

# Finally, if $HOME/.localrc exists (private stuff, not in a public git repo)
if [ -f $HOME/.localrc ]; then
    loader_report "Loading" $HOME/.localrc
    source $HOME/.localrc
fi

unset -v findopts
