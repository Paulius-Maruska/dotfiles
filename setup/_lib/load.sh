_dotfiles_log(){
    if [ "$DOTFILESDEBUG" -eq 1 ]; then
        local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        local level=$1
        local message=$2

        if [ "$level" = "debug" ]; then
            printf "\033[37m[\033[0m \033[36m%s\033[0m \033[37m]\033[0m \033[37m[\033[0m \033[1;32m%5s\033[0m \033[37m]\033[0m %s\n" "$timestamp" "$level" "$message"
        elif [ "$level" = "info" ]; then
            printf "\033[37m[\033[0m \033[36m%s\033[0m \033[37m]\033[0m \033[37m[\033[0m \033[0;34m%5s\033[0m \033[37m]\033[0m %s\n" "$timestamp" "$level" "$message"
        elif [ "$level" = "warn" ]; then
            printf "\033[37m[\033[0m \033[36m%s\033[0m \033[37m]\033[0m \033[37m[\033[0m \033[0;33m%5s\033[0m \033[37m]\033[0m %s\n" "$timestamp" "$level" "$message"
        elif [ "$level" = "error" ]; then
            printf "\033[37m[\033[0m \033[36m%s\033[0m \033[37m]\033[0m \033[37m[\033[0m \033[0;31m%5s\033[0m \033[37m]\033[0m %s\n" "$timestamp" "$level" "$message"
        else
            printf "\033[37m[\033[0m \033[36m%s\033[0m \033[37m]\033[0m \033[37m[\033[0m \033[0;35m%5s\033[0m \033[37m]\033[0m %s\n" "$timestamp" "$level" "$message"
        fi
    fi
}

alias _debug='_dotfiles_log debug'
alias _info='_dotfiles_log info'
alias _warn='_dotfiles_log warn'
alias _error='_dotfiles_log error'

loader_list_files_in_correct_order(){
    # Files from env first (these are supposed to setup env variables)
    find -H $DOTFILES/env -name '*.sh'|sort
    # Files from $DOTFILESSHELL second
    find -H $DOTFILES/$DOTFILESSHELL -name '*.sh'|sort
    # Everything else
    find -H $DOTFILES -name '*.sh' -mindepth 2 -not -path '*.git*' -not -path '*setup*' -not -path '*env*' -not -path '*zsh*' -not -path '*bash*'|sort
    # Lastly load the private file
    echo "$HOME/.localrc"
}

install_list_files_link(){
    # *.link files need to be linked in $HOME
    find -H $DOTFILES -name '*.link' -mindepth 2 -not -path '*.git' -not -path '*setup*'|sort
}

install_list_files_script(){
    # *.link files need to be linked in $HOME
    find -H $DOTFILES -name '*.script' -mindepth 2 -not -path '*.git' -not -path '*setup*'|sort
}
