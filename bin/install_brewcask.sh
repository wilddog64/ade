#!/usr/bin/env bash

function install_brewcask() {
    output=$(brew tap | grep cask)
    if [[ $? = 0 ]]; then
        echo [ok] caskroom/cask installed
    else
        # tap 
        brew tap caskroom/cask
        brew install brew-cask
    fi
}
