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

function install_ruby_bundle() {
    require_gem bundle
    bundle update >> /dev/null
    bundle install >> /dev/null
}

function install_ruby() {
    local ruby_version=$1
    install_rbenv
    install_ruby_bundle
    require_ruby $ruby_version
}
