#!/usr/bin/env bash

function install_homebrew() {
    if [[ $(uname) != 'Darwin' ]]; then
        echo homebrew can only be installed for OSX Darwin, script $0 abort!
    fi

    brew_bin=$(which brew) 2>&1 > /dev/null
    if [[ $? != 0 ]]; then
        ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    else
        echo $brew_bin exist!
    fi
    if [[ $? != 0 ]]; then
        echo unable to install homebrew, script $0 abort!
    fi
}
