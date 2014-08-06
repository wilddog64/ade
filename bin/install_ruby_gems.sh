#!/usr/bin/env bash


function install_rbenv() {
    require_brew rbenv
    require_brew ruby-build
    init_rbenv ~/.bashrc
    # if [[ $(grep rbenv ~/.bashrc) != 0 ]]; then
    #     echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    # fi
}

function install_ruby() {
    local version=$1

    rbenv version | grep $version
    if [[ $? != 0 ]]; then
        rbenv install $version
        rbenv local $version
    fi
}

function install_bundle() {
   require_gem bundle
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
    install_bundle
    update_ruby_gems
    install_ruby_gems
}


