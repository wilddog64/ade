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
   local gem=$1
   local running_as_root=$2

   [[ -z $running_as_root ]] && running_as_root=0
    running "gem $gem"
    gem list --local | grep "$gem\b"
    if [[ $? != 0 ]]; then
       action "installing gem $gem"
       if [[ $running_as_root = 1 ]]; then
         action install $gem as a privillege user
         sudo gem install --no-rdoc --no-ri $gem
       else
         gem install --no-rdoc --no-ri $gem
       fi

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

function require_npm() {
    local node_package=$1

    running "checking $node_package"
    npm list -g $node_package > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
       action "npm install -g $node_package"
       npm install -g $node_package 2>&1 > /dev/null
       if [[ $? != 0 ]]; then
          error "failed to install $node_package"
       fi
    fi
    ok
}

