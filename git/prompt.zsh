autoload colors && colors

_THEME_GIT_LOCAL="${fg_bold[magenta]}_NAME_${reset_color}"
_THEME_GIT_REMOTE="${fg_bold[green]}_NAME_${reset_color}"
_THEME_GIT_NOREMOTE="${fg[red]}**untracked**${reset_color}"
_THEME_GIT_OK=" ${fg[green]}✔${reset_color}"
_THEME_GIT_UNTRACKED=" ${fg[magenta]}⁇ _NUMBER_${reset_color}"
_THEME_GIT_CHANGED=" ${fg[cyan]}± _NUMBER_${reset_color}"
_THEME_GIT_CONFLICTS=" ${fg[red]}⚠ _NUMBER_${reset_color}"
_THEME_GIT_STAGED=" ${fg[green]}➩ _NUMBER_${reset_color}"
_THEME_GIT_STASHES=" ${fg_bold[blue]}⚑ _NUMBER_${reset_color}"
_THEME_GIT_AHEAD=" ${fg[blue]}▲ _NUMBER_${reset_color}"
_THEME_GIT_BEHIND=" ${fg[red]}▼ _NUMBER_${reset_color}"

_git_state_output () {
    local local_name="$1"
    local remote_name="$2"
    local files_untracked="$3"
    local files_changed="$4"
    local files_conflicts="$5"
    local files_staged="$6"
    local stashes="$7"
    local rev_ahead="$8"
    local rev_behind="$9"

    local git_status=
    if [ -n "$local_name" ]; then
        local local_branch= local_state=
        local_branch="${_THEME_GIT_LOCAL//_NAME_/$local_name}"

        if [ $files_staged -ne 0 ]; then
            local_state="${local_state}${_THEME_GIT_STAGED//_NUMBER_/$files_staged}"
        fi
        if [ $files_changed -ne 0 ]; then
            local_state="${local_state}${_THEME_GIT_CHANGED//_NUMBER_/$files_changed}"
        fi
        if [ $files_untracked -ne 0 ]; then
            local_state="${local_state}${_THEME_GIT_UNTRACKED//_NUMBER_/$files_untracked}"
        fi
        if [ $files_conflicts -ne 0 ]; then
            local_state="${local_state}${_THEME_GIT_CONFLICTS//_NUMBER_/$files_conflicts}"
        fi
        if [ $stashes -ne 0 ]; then
            local_state="${local_state}${_THEME_GIT_STASHES//_NUMBER_/$stashes}"
        fi
        if [ -z "$local_state" ]; then
            local_state="$_THEME_GIT_OK"
        fi

        git_status="$(output_prompt_value "${local_branch}${local_state}${reset_color}")"
    fi

    if [ "$remote_name" != "." ]; then
        local remote_branch= remote_state=
        remote_branch="${_THEME_GIT_REMOTE//_NAME_/$remote_name}"

        if [ $rev_ahead -ne 0 ]; then
            remote_state="${remote_state}${_THEME_GIT_AHEAD//_NUMBER_/$rev_ahead}"
        fi
        if [ $rev_behind -ne 0 ]; then
            remote_state="${remote_state}${_THEME_GIT_BEHIND//_NUMBER_/$rev_behind}"
        fi
        if [ -z "$remote_state" ]; then
            remote_state="$_THEME_GIT_OK"
        fi

        git_status="${git_status}$(output_prompt_value "${remote_branch}${remote_state}${reset_color}")"
    else
        local remote_branch="${_THEME_GIT_NOREMOTE//_NAME_/$remote_name}"
        git_status="${git_status}$(output_prompt_value "${remote_branch}")"
    fi

    if [ -n "$git_status" ]; then
        echo "$git_status"
    fi
}

git_state_sample () {
    echo "git state is something shown to you in your prompt."
    echo -
    echo "current theme:"
    echo "  ${_THEME_GIT_LOCAL//_NAME_/local-name}\t\tlocal branch or tag name or commit name"
    echo "  ${_THEME_GIT_REMOTE//_NAME_/remote/remote-name}\tname of the remote branch that is currently tracked by your local branch"
    echo "  ${_THEME_GIT_NOREMOTE//_NAME_/.}\t\tstring shown when remote tracked branch is not available or not set"
    echo "  ${_THEME_GIT_OK}\t\t\tshown, when there are no local changes and local branch is in sync with remote branch"
    echo "  ${_THEME_GIT_UNTRACKED//_NUMBER_/1}\t\t\tnumber of untracked files"
    echo "  ${_THEME_GIT_CHANGED//_NUMBER_/1}\t\t\tnumber of changed files"
    echo "  ${_THEME_GIT_CONFLICTS//_NUMBER_/1}\t\t\tnumber of conflicts"
    echo "  ${_THEME_GIT_STAGED//_NUMBER_/1}\t\t\tnumber of staged files"
    echo "  ${_THEME_GIT_STASHES//_NUMBER_/1}\t\t\tnumber of local stashes"
    echo "  ${_THEME_GIT_AHEAD//_NUMBER_/1}\t\t\tnumber of local unpushed commits"
    echo "  ${_THEME_GIT_BEHIND//_NUMBER_/1}\t\t\tnumber of remote unpulled commits"
    echo -
    echo "sample states:"
    echo "  $(_git_state_output branch . 0 0 0 0 0 0 0)"
    echo "  $(_git_state_output branch remote/branch 1 2 3 4 5 6 7)"
    echo "  $(_git_state_output branch remote/branch 0 0 0 0 0 0 0)"
    echo -
}

git_precmd () {
    typeset -a gs
    gs=( $(gitstatus) )
    if [ "$?" = "0" -a -n "$gs" ]; then
        _git_state_output $gs
    fi
}

typeset -a precmd_functions
precmd_functions+="git_precmd"
