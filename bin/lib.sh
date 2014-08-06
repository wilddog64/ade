#!/usr/bin/env bash

function require_cask() {
    brew cask list $1
    if [[ $? != 0 ]]; then
        echo $1 is not installed yet, installing...
        brew cask install $1
        if [[ $? != 0 ]]; then
            echo failed to install $1! aborting...
            exit -1
        fi
    fi
}
function require_brew() {
    brew list $1
    if [[ $? != 0 ]]; then
        echo $1 is not installed yet, installing...
        brew install $1
        if [[ $? != 0 ]]; then
            echo failed to install $1! aborting...
            exit -1
        fi
    fi
}
function require_gem() {
	gem list --local $1
    if [[ $? != 0 ]]; then
        echo $1 is not installed yet, installing...
        gem install $1
        if [[ $? != 0 ]]; then
            echo failed to install $1! aborting...
            exit -1
        fi
    fi
}