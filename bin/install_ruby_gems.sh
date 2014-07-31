#!/usr/bin/env bash

function install_bundle() {
   gem install bundle
}

function install_ruby_gems() {
    bundle install
}

function update_ruby_gems() {
    bundle update
}

function install_all_rubygems() {
    install_bundle
    update_ruby_gems
    install_ruby_gems
}


