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
    install_homebrew
    install_brewcask
    install_vagrant_and_plugins
}

case "$1" in
	init)
        init_devenv
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

