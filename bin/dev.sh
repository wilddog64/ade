#!/bin/bash

set -e

# vagrant up

source ./bin/install_homebrew.sh
source ./bin/install_brewcask.sh
source ./bin/install_vagrant.sh

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

cd $SCRIPT_HOME/..

SCRIPT_BIN=$SCRIPT_HOME/bin

function init_devenv() {
    local reload=$1

    install_homebrew
    install_brewcask
    install_vagrant_and_plugins

    if [[ $reload = 1 ]]; then
        vagrant reload --provision
    else
        vagrant up
    fi
}

case "$1" in
    init)
        init_devenv
        ;;
    vagrant-up)
        vagrant up
        ;;
    vagrant-reload)
        vagrant reload --provision
        ;;
    vagrant-destroy-up)
        vagrant destroy -f
        vagrant up
        ;;
    update)
        git pull
        vagrant ssh -c "sudo /vagrant/bin/devenv-inner.sh update"
        ;;
    *)
        vagrant ssh -c "sudo /vagrant/bin/devenv-inner.sh $1"
        ;;
esac

cd - > /dev/null

