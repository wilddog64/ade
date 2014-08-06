#!/usr/bin/env bash

function require_cask() {
    brew cask list $1
    if [[ $? != 0 ]]; then
        echo '[missing] '$1'. installing...'
        brew cask install $1
        if [[ $? != 0 ]]; then
            echo '[error] failed to install $1! aborting...'
            exit -1
        fi
    fi
}

function require_brew() {
    brew list $1
    if [[ $? != 0 ]]; then
        echo '[missing] '$1'. installing...'
        brew install $1
        if [[ $? != 0 ]]; then
            echo '[error] failed to install $1! aborting...'
            exit -1
        fi
    fi
}

function require_gem() {
    if [[ $(gem list --local | grep $1 | head -1 | cut -d' ' -f1) == $1 ]];
        then
            echo '[ok] '$1' is already installed';
        else
            echo '[missing] '$1'. installing...';
            gem install $1
    fi
}

function require_vagrant_plugin() {
    if [[ $(gem list --local | grep $1 | head -1 | cut -d' ' -f1) == $1 ]];
        then
            echo '[ok] '$1' is already installed';
        else
            echo '[missing] '$1'. installing...';
            gem install $1
    fi
}

function init_rbenv() {
    local rcfile=$1
    local rc=0

    if [[ ! -e $rcfile ]]; then
        touch $rcfile
    fi

    if [[ $(grep rbenv $rcfile) != 0 ]]; then
        echo 'eval "$(rbenv init -)"' >> $rcfile
    fi
}
