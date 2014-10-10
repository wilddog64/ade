#!/usr/bin/env bash

function install_homebrew() {
    running "checking homebrew"
    brew_bin=$(which brew) 2>&1 > /dev/null
    if [[ $? != 0 ]]; then
    	action "installing homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        if [[ $? != 0 ]]; then
            error "unable to install homebrew, script $0 abort!"
            exit -1
    	fi
    fi
    ok
}

function require_brew() {
    local brew=$1
    running "brew $brew $2"
    brew list $brew > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew install $brew $2"
        brew install $brew $2
        if [[ $? != 0 ]]; then
            error "failed to install $brew! aborting..."
            exit -1
        fi
    fi
    ok
}

