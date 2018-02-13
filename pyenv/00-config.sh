# if $HOME/.pyenv exists, load pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
else
  echo "pyenv is not installed, use 'pyenv-setup' to install it."
fi
