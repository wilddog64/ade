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
    if [[ $(gem list --local | grep $1 | head -1 | cut -d' ' -f1) == $1 ]];
        then
            echo $1' is already installed, skipping...';
        else
            echo $1' missing. installing...';
            gem install $1
    fi
}
