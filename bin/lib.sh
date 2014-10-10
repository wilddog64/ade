#!/usr/bin/env bash

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

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

function require_brew() {
    local brew=$1
    running "brew $brew $2"
    brew list $brew > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; then
        action "brew install $brew $2"
        brew install $brew $2
        if [[ $? != 0 ]]; then
            error "failed to install $brew! aborting..."
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

    if [[ $grepStatus != $grepExpect ]];
        then
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

# getScriptDir is a bash function that return the current execution script
# directory.  The script # will also follow the symlink to find out the
# correct directory.  It takes no parameters.
function _getScriptDir() {
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      SOURCE="$(readlink "$SOURCE")"
      # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    echo "$( cd -P "$( dirname "$SOURCE" )" && pwd )"
}

