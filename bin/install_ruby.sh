#!/usr/bin/env bash

PATH=/usr/local/bin:~/.linuxbrew/bin:$PATH

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
    # install_rbenv
    require_ruby $ruby_version
    rbenv local $ruby_versioin
    install_ruby_bundle
}
