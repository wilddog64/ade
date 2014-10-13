#!/usr/bin/env bash

function install_brewcask() {
    action 'checking platform'
    platform=$(get_os_platform)
    if [[ "$platform" != "Darwin" ]]; then
	warn "brew-cask only work for Darwin"
	return 1
    fi

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
