#!/usr/bin/env bash
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

source $DOTFILES_ROOT/setup/functions.sh

set -e

uninstall_dotfiles
