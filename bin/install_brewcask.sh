#!/usr/bin/env bash

function install_brewcask() {
    output=$(brew tap | grep cask)
    if [[ $? = 0 ]]; then
        ok "caskroom/cask is installed"
    else
        # tap 
        brew tap caskroom/cask
        brew install brew-cask
    fi
}
