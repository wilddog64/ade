#!/usr/bin/env bash

function install_homebrew() {
    if [[ $(uname) != 'Darwin' ]]; then
        echo [warning] homebrew can only be installed for OSX Darwin!
    fi

    brew_bin=$(which brew) 2>&1 > /dev/null
    if [[ $? != 0 ]]; then
        ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    else
        echo [ok] $brew_bin exists
    fi
    if [[ $? != 0 ]]; then
        echo [error] unable to install homebrew, script $0 abort!
        exit -1
    fi
}
