#!/usr/bin/env bash

# use system ruby

function _getScriptDir() {
    unset CDPATH               # so this script won't be affect by CDPATH variable
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      SOURCE="$(readlink "$SOURCE")"
      # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    echo "$( cd -P "$( dirname "$SOURCE" )" && pwd )"
}

# figure where this script located
SCRIPT_HOME=$(dirname $(_getScriptDir))
SCRIPT_BIN=$SCRIPT_HOME/bin

cd $SCRIPT_HOME
source $SCRIPT_BIN/console.sh
source $SCRIPT_BIN/lib.sh

function check_system_ruby() {
    which ruby
}

function check_brew_exist() {
    local brew_exists=0
    if [[ -e /usr/local/bin/brew ]]; then
	brew_exists=1
    fi

    echo $brew_exists
}

function install_required_gems() {

    if [[ -z check_system_ruby ]]; then
	bot 'Looks like you do not have brew on your system so I am working on it ...'	
    else
	require_gem facter 1
    fi
}

function get_os_platform() {
    install_required_gems

    local facter_bin=$(which facter)
    if [[ -z $facter_bin ]]; then
	error 'facter does not install script abort'
    fi
    $facter_bin os -y | ruby -ryaml -e "print YAML.load( STDIN.read )['os']['name']"	
}
