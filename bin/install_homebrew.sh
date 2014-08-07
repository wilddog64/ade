#!/usr/bin/env bash

function install_homebrew() {
    if [[ $(uname) != 'Darwin' ]]; then
        warn "homebrew can only be installed for OSX Darwin!"
    fi

    brew_bin=$(which brew) 2>&1 > /dev/null
    if [[ $? != 0 ]]; then
        ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    else
        ok "$brew_bin exists"
    fi
    if [[ $? != 0 ]]; then
        error "unable to install homebrew, script $0 abort!"
        exit -1
    fi
}
