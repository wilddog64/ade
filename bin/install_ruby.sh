#!/usr/bin/env bash

function init_rbenv() {
    running "init rbenv"
    local rcfile=$1
    local rc=0

    if [[ ! -e $rcfile ]]; then
    	action "$rcfile does not exist, creating"
        touch $rcfile
        ok
    fi
    output=$(grep rbenv $rcfile);
    if [[ $? != 0 ]]; then
    	action "populating rcfile with rbenv init"
        echo 'eval "$(rbenv init -)"' >> $rcfile
    	action "resourcing rcfile"
    	source ~/.bashrc
    fi
    ok
}

function install_rbenv() {
    require_brew rbenv
    require_brew ruby-build
    init_rbenv ~/.bashrc
}

function rbenv_rehash() {
    action 'rehash rbenv'
    eval "$(rbenv init -)"
}

function install_ruby_bundle() {
    require_gem bundler
    rbenv_rehash
    bundle update >> /dev/null
    bundle install >> /dev/null
}

function require_ruby() {
    local version=$1
    running "need ruby version $version"
    output=$(rbenv versions | grep $version);
    if [[ $? != 0 ]]; then
        action "installing ruby $version"
        rbenv install $version
        rbenv local $version
    fi
    ok
}

function install_ruby() {
    local ruby_version=$1
    install_rbenv
    require_ruby $ruby_version
    rbenv local $ruby_versioin
    install_ruby_bundle
}
