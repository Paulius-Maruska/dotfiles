# prompt settings
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1
source $DOTFILES/git/git-sh-prompt

__dotfiles_git_ps1(){
  typeset ret=$?
  __git_ps1 "" "" " : %s"
  return $ret
}
