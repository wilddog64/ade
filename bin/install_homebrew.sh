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
