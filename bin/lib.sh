#!/usr/bin/env bash

function require_cask() {
    running "brew cask $1"
    brew cask list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew cask install $1 $2"
        brew cask install $1
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            exit -1
        fi
    fi
    ok
}

function require_gem() {
    running "gem $1"
    gem list --local | grep "$1\b"
    if [[ $? != 0 ]]; then
       action "installing gem $1"
       gem install --no-rdoc --no-ri $1
    fi
    ok
}

function require_vagrant_plugin() {
    running "vagrant plugin $1"
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

    if [[ $grepStatus != $grepExpect ]]; then
            action "missing vagrant plugin $1 $2"
            if [[ ! -z $vagrant_plugin_version ]]; then
                vagrant plugin install $vagrant_plugin --plugin-version $vagrant_plugin_version
            else
                vagrant plugin install $vagrant_plugin
            fi
    fi
    ok
}

function cleanup_untrack_bin_files() {
   git clean -f -X ./bin
}
