if [ "$DOTFILESPLATFORM" = "Darwin" ]; then
    _info "loading git completions for Darwin"
    if [ "$DOTFILESSHELL" = "bash" ]; then
        source $HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash
    fi
    if [ "$DOTFILESSHELL" = "zsh" ]; then
        fpath+="$HOMEBREW_PREFIX/opt/git/share/zsh/site-functions"
    fi
fi

# setup git aliases
# We do this, by removing current aliases, and then adding them again
git config --global --remove-section alias 2>&1 >/dev/null

# git debug <subcomand> ...
# shows git trace on stderr for the given <subcommand> and its parameters
git config --global alias.debug '!GIT_TRACE=2 git'

# git alias <name> <value>
# shortcut for defining a new alias
git config --global alias.alias "!git config --global \"alias.\$1\" \"\$2\"  #"

# shorter aliases for subcommands
git alias br       branch
git alias ci       commit
git alias co       checkout
git alias re       remote
git alias st       status

# shortening specific stuff
git alias alist    'config --global --get-regexp "alias.*"'
git alias brd      'branch -d'
git alias brm      'branch -m'
git alias cia      'commit --amend'
git alias cim      'commit -m'
git alias cob      'checkout -b'
git alias com      'checkout master'
git alias last     'log -1 HEAD'
git alias lg       'log --all --graph --decorate --oneline'
git alias rea      'remote -v'
git alias reu      'remote update'
git alias reup     'remote update --prune'

# outputs current branch
git alias current  'rev-parse --abbrev-ref HEAD'

# start new repository
git alias start    "! a=\"\$1\" && shift && git init \"\$a\" && cd \"\$a\" && git commit --allow-empty --message 'Initial commit'"

# output all commits that are included in specific merge(s)
git alias prf      "! a=\"\$1\" && shift && for h in \$(git log --merges --pretty=format:%H --grep=\"\$a\"); do s=\"\$(git log -1 --merges --pretty=format:%P \"\$h\")\"; p=\"\$(git merge-base --octopus \$s)\"; git log \$p..\$h \"\$@\"; echo ''; done  #"
git alias pr       "! a=\"\$1\" && shift && git prf \"\$a\" --pretty=oneline \"\$@\"  #"
git alias prb      "! a=\"\$1\" && shift && git prf \"\$a\" --pretty=%H \"\$@\"  #"
