#!/bin/bash

#set -e

# vagrant up

source ./bin/lib.sh
source ./bin/install_homebrew.sh
source ./bin/install_brewcask.sh
source ./bin/install_vagrant.sh
source ./bin/install_ruby_gems.sh

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

cd $SCRIPT_HOME/..

SCRIPT_BIN=$SCRIPT_HOME/bin

function init_devenv() {
    local reload=$1

    thor devenv:vagrant
    source ./bin/install_vagrant_plugins.sh
    install_homebrew
    install_brewcask
    install_vagrant_and_plugins
    install_all_rubygems

    # make sure mount directories exist
    # TODO: might move these into Vagrant stuff
    mkdir -p ~/src

    if [[ $reload = 1 ]]; then
        action "reloading vagrant..."
        vagrant reload --provision
    else
        action "starting vagrant..."
        vagrant up
    fi
}

case "$1" in
    init)
        init_devenv
        ;;
    purge)
        rm -rf Vagrantfile
        brew cask uninstall vagrant | true 
        gem uninstall bundle | true
        brew uninstall rbenv | true
        ok "all clear - now run ./bin/dev.sh init again :)"
        ;;
    start)
        vagrant up
        ;;
    reload)
        export RELOAD=1
        rm -rf Vagrantfile
        thor devenv:vagrant
        vagrant reload --provision
        ;;
    recreate)
        rm -rf Vagrantfile
        thor devenv:vagrant
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

