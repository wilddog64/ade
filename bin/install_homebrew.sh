#!/usr/bin/env bash

function require_brew() {
    local brew=$1

    PATH=/usr/local/bin:~/.linuxbrew/bin:$PATH
    local brew_bin=$(which brew)
    echo $brew_bin
    running "brew $brew $2"
    # brew list $brew > /dev/null 2>&1 | true
    if [[ $(which rbenv) != 0 ]]; then
        action "brew install $brew $2"
        brew install $brew $2
        if [[ $? != 0 ]]; then
            error "failed to install $brew! aborting..."
            exit -1
        fi
    fi
    ok
}

