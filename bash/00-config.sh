# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# OS X configuration
if [ "$DOTFILESPLATFORM" = "Darwin" ]; then
    # MAC has fucked up locale setting by default, fix it here
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
fi
