#!/usr/bin/env bash


function install_rbenv() {
    require_brew rbenv
    require_brew ruby-build
    init_rbenv ~/.bashrc
    source ~/.bashrc
}

function install_ruby() {
    local version=$1

    rbenv version | grep $version
    if [[ $? != 0 ]]; then
        rbenv install $version
        rbenv local $version
    fi
}

function install_ruby_gems() {
    bundle install
}

function update_ruby_gems() {
    bundle update
}

function install_all_rubygems() {
    install_rbenv
    install_ruby 1.9.3-p547
    require_gem bundle
    update_ruby_gems
    install_ruby_gems
}


