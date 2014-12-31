#!/usr/bin/env bash

_install_git_osx () {
    if [ "$(brew ls --versions git)" = "" ]; then
        brew install git
    fi
}

platform="$(uname)"
if [ "$platform" = "Darwin" ]; then
    _install_git_osx
fi
