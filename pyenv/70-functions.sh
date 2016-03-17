pyenv-run-all() {
  local orig=$PYENV_VERSION
  local cmd="$*"
  local cmdreal=""
  local found=""
  local w=$(printf "=%.0s" {1..80})
  local s=$(printf "-%.0s" {1..80})
  for ver in $(pyenv versions --bare); do
    if [ -n "$found" ]; then
      found+=", "
    fi
    found+="$ver"
  done
  printf "%.80s\n" "$w"
  printf "Installed Versions: %s\n" "$found"
  printf "Command: %s\n" "$cmd"
  for ver in $(pyenv versions --bare); do
    export PYENV_VERSION=$ver
    printf "[ %-20s ]%.56s\n" "$ver" "$s"
    cmdreal="${cmd/\{VERSION\}/$ver}"
    eval "$cmdreal"
  done
  export PYENV_VERSION=$orig
}
