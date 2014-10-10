#!/usr/bin/env bash

# use system ruby
RUBY_BIN=/usr/bin/ruby
RUBY_GEM=/usr/bin/gem

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


