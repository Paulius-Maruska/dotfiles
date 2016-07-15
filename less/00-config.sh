# make less more friendly for non-text input files, see lesspipe(1)
if [ -n "$(command -v lesspipe)" ]; then
    # on linux (well, at least on ubuntu) the .sh suffix is not needed
    eval "$(SHELL=/bin/sh lesspipe)"
elif [ -n "$(command -v lesspipe.sh)" ]; then
    # lesspipe installed with brew on osx is called "lesspipe.sh"
    eval "$(SHELL=/bin/sh lesspipe.sh)"
fi
