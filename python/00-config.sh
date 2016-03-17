# tell virtualenv not to mess with PS1
VIRTUAL_ENV_DISABLE_PROMPT=yes

# if $HOME/.pyenv exists, load pyenv stuff
if [ -d "$HOME/.pyenv" ]; then
    export PATH="/home/pam/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
fi
