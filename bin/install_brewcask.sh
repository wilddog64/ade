#!/usr/bin/env bash

function install_brewcask() {
    running "checking brew-cask"
    output=$(brew tap | grep cask)
    if [[ $? != 0 ]]; then
	action "tap into brew-cask"
	brew tap caskroom/homebrew-cask

	action "installing brew-cask"
	brew install brew-cask
    fi
ok
}
