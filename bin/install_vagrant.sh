#!/usr/bin/env bash

# vagrant plugin install vagrant-omnibus
# vagrant plugin install vagrant-berkshelf --plugin-version 2.0.1
function install_vagrant_and_plugins() {
    require_cask vagrant
    require_vagrant_plugin vagrant-omnibus
    require_vagrant_plugin vagrant-berkshelf 2.0.1
    require_vagrant_plugin vagrant-cachier
}
