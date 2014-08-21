#!/usr/bin/env bash

function install_brewcask() {
	running "checking brew-cask"
    output=$(brew tap | grep cask)
    if [[ $? != 0 ]]; then
    	action "installing brew-cask"
        # tap
        brew tap caskroom/cask
        brew install brew-cask
    fi
    ok
}
