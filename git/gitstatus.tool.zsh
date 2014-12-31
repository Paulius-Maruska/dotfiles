#!/usr/bin/env zsh

# inspired by (but not really an exact port of) bash-git-prompt gitstatus.sh
# https://github.com/magicmonty/bash-git-prompt/blob/master/gitprompt.sh

_gitstatus () {
    # get current symref or error
    # there are 2 expected errors:
    # 1) not a git repository
    # 2) ref HEAD is not a symbolic ref
    local gitsym="$(git symbolic-ref HEAD 2>&1)"

    # if "fatal: Not a git repository..." - return
    local not_repo="fatal: Not a git repository"
    if [ "${gitsym#$not_repo*}" != "${gitsym}" ]; then
        return 1
    fi

    local local_name= remote_name=
    typeset -i rev_ahead rev_behind

    # if "fatal: ref HEAD is not a symbolic ref"
    local no_sym="fatal: ref HEAD is not a symbolic ref"
    if [ "${gitsym}" != "${no_sym}" ]; then
        # the current branch is the tail end of the symbolic reference
        local_name="${gitsym##refs/heads/}"

        local remote="$(git for-each-ref --format='%(upstream:short)' $gitsym)"
        if [ -n "$remote" ]; then
            remote_name="$remote"

            local rev="$(git rev-list --left-right $remote_name...HEAD)"
            rev_ahead="$(echo "$rev" | egrep -c '^>')"
            rev_behind="$(echo "$rev" | egrep -c '^<')"
        fi
    else
        local gittag="$(git describe --exact-match 2>&1)"
        if [ "${gittag#fatal*}" = "${gittag}" ]; then
            local_name="$gittag"
        else
            local_name="$(git rev-parse --short HEAD 2>&1)"
        fi
    fi
    if [ -z "$remote_name" ]; then
        remote_name="."
    fi

    local git_status="$(git diff --name-status)"
    local git_staged="$(git diff --name-status --staged)"

    typeset -i git_status_all git_staged_all git_status_unmerged
    git_status_all="$(echo "$git_status" | grep -v '^$' | wc -l)"
    git_status_unmerged="$(echo "$git_status" | egrep -c '^U')"
    git_staged_all="$(echo "$git_staged" | grep -v '^$' | wc -l)"

    typeset -i files_untracked files_changed files_conflicts files_staged files_stashed
    files_untracked="$(git ls-files --others --exclude-standard | wc -l)"
    files_changed=$(( git_status_all - git_status_unmerged ))
    files_conflicts="$(echo "$git_staged" | egrep -c '^U')"
    files_staged=$(( git_staged_all - files_conflicts ))

    typeset -i stashes
    stashes="$(git stash list | wc -l)"

    # output space separated list of values
    echo "$local_name"
    echo "$remote_name"
    echo "$files_untracked"
    echo "$files_changed"
    echo "$files_conflicts"
    echo "$files_staged"
    echo "$stashes"
    echo "$rev_ahead"
    echo "$rev_behind"
}

_gitstatus
exit $?
