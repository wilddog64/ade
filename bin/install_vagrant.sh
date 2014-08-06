#!/usr/bin/env bash

function install_vagrant() {

    brew cask list vagrant
    if [[ $? != 0 ]]; then
        echo vagrant is not installed yet, install it now
        brew cask install vagrant
        if [[ $? != 0 ]]; then
            echo failed to install vagrant, script abort!
            exit -1
        fi
    fi
}

function install_vagrant_plugin() {
    local vagrant_plugin=$1
    local vagrant_plugin_version=$2
    local grepExpect=$vagrant_plugin
    local grepStatus=$(vagrant plugin list | grep $vagrant_plugin)

    if [[ ! -z $vagrant_plugin_version ]]; then
        grepExpect=$grepExpect' ('$vagrant_plugin_version')'
    else
        # we are only looking for the name
        grepStatus=${grepStatus%% *}
    fi

    #echo 'checking if '$grepExpect' is installed via grepStatus: '$grepStatus

    if [[ $grepStatus == $grepExpect ]];
        then
            echo $vagrant_plugin' is already installed, skipping';
        else
            echo $vagrant_plugin' missing';
            if [[ ! -z $vagrant_plugin_version ]]; then
                vagrant plugin install $vagrant_plugin --plugin-version $vagrant_plugin_version
            else
                vagrant plugin install $vagrant_plugin
            fi
    fi
}

# vagrant plugin install vagrant-omnibus
# vagrant plugin install vagrant-berkshelf --plugin-version 2.0.1
function install_vagrant_and_plugins() {
    install_vagrant
    install_vagrant_plugin vagrant-omnibus
    install_vagrant_plugin vagrant-berkshelf 2.0.1
    install_vagrant_plugin vagrant-cachier
    install_bundle
}
