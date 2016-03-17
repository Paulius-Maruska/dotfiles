# if $HOME/.pyenv exists, load pyenv stuff
if [ -d "$HOME/.pyenv" ]; then
    export PATH="/home/pam/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
fi
