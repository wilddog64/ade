#!/usr/bin/env bash

function install_all_rubygems() {
    require_brew rbenv
    require_brew ruby-build
    init_rbenv ~/.bashrc
    source ~/.bashrc
    require_ruby 1.9.3-p547
    require_gem bundle
    bundle update >> /dev/null
    bundle install >> /dev/null
}

function require_ruby() {
    local version=$1
    echo "looking for ruby version $version..."
    output=$(rbenv versions | grep $version);
    if [[ $? != 0 ]]; then
        action "installing ruby $version"
        rbenv install $version
        rbenv local $version
    else
        ok "ruby $version installed"
    fi
}