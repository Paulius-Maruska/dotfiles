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

pyenv-setup() {
  if [ -d "$PYENV_ROOT" ]; then
    echo "pyenv already installed"
    return 0
  fi
  git clone --depth 1 "git://github.com/yyuu/pyenv.git" "${PYENV_ROOT}"
  git clone --depth 1 "git://github.com/yyuu/pyenv-doctor.git" "${PYENV_ROOT}/plugins/pyenv-doctor"
  git clone --depth 1 "git://github.com/yyuu/pyenv-installer.git" "${PYENV_ROOT}/plugins/pyenv-installer"
  git clone --depth 1 "git://github.com/yyuu/pyenv-update.git" "${PYENV_ROOT}/plugins/pyenv-update"
  git clone --depth 1 "git://github.com/yyuu/pyenv-virtualenv.git" "${PYENV_ROOT}/plugins/pyenv-virtualenv"
  git clone --depth 1 "git://github.com/yyuu/pyenv-which-ext.git" "${PYENV_ROOT}/plugins/pyenv-which-ext"

  echo "pyenv installed successfully, please restart your shell"
}

pyenv-stable-latest() {
  local majorminor="$1"
  if [ -z "$majorminor" ]; then
    echo "$0 requires a [TITLE-]MAJOR.MINOR argument"
    echo "For example:"
    echo "   $0 3.6"
    echo "   $0 pypy3-2.4"
    return 1
  fi
  local pattern="$(printf '^[[:space:]]+%s\.[[:digit:]]+$' ${majorminor/./\.})"
  pyenv install --list | egrep "$pattern" | sort -t . -k 3gr | head -n1
}

pyenv-stable-list() {
  local search="$1"
  if [ -n "$search" ]; then
    search="$(printf '%s[[:alnum:]]*-' "$search")"
  fi
  local pattern="$(printf '^[[:space:]]+%s[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]$' "$search")"
  local majorminorlist=( $(pyenv install --list | egrep "$pattern" | cut -s -d . -f 1,2 | uniq) )
  for majorminor in "${majorminorlist[@]}"; do
    pyenv-stable-latest "${majorminor/  /}"
    if [ $? -ne 0 ]; then
      echo "aborting..."
      return 1
    fi
  done
}

pyenv-install-latest() {
  if [ -z "$*" ]; then
    echo "$0 requires at least one version to install"
    echo "For example:"
    echo "  $0 2.7 3.5 3.6 pypy3-2.4"
    return 1
  fi
  echo "resolving versions..."
  local version=""
  local versions=( )
  for ver in "${*[@]}"; do
    version="$(pyenv-stable-latest $ver)"
    if [ $? -ne 0 ]; then
      echo "aborting..."
      return 1
    fi
    if [ -z "$version" ]; then
      echo "could not resolve version $ver"
      return 1
    fi
    version="${version/  /}"
    echo "resolved version $ver => $version"
    versions=( "${versions[@]}" "$version" )
  done
  echo "==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ===="
  for ver in "${versions[@]}"; do
    echo "Installing version: $ver"
    pyenv install $ver
    if [ $? -ne 0 ]; then
      echo "aborting..."
      return 1
    fi
  done
}
