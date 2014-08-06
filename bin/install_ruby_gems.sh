#!/usr/bin/env bash

function install_all_rubygems() {
    require_brew rbenv
    require_brew ruby-build
    init_rbenv ~/.bashrc
    source ~/.bashrc
    require_ruby 1.9.3-p547
    require_gem bundle
    bundle update
    bundle install
}

function require_ruby() {
    local version=$1

    output=$(rbenv version | grep $version);
    if [[ $? != 0 ]]; then
        action "installing ruby 1.9.3-p547"
        rbenv install $version
        rbenv local $version
    else
        ok "ruby $version installed"
    fi
}