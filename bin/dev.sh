#!/bin/bash

#set -e

# vagrant up

source ./bin/lib.sh
source ./bin/install_homebrew.sh
source ./bin/install_brewcask.sh
source ./bin/install_ruby_gems.sh

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

cd $SCRIPT_HOME/..

SCRIPT_BIN=$SCRIPT_HOME/bin

function init_devenv() {
    local reload=$1

    install_homebrew
    install_brewcask
    require_cask vagrant
    install_all_rubygems
    
    thor devenv:vagrant
    source ./bin/install_vagrant_plugins.sh
    install_vagrant_plugins
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

function purge() {
    vagrant halt > /dev/null 2>&1
    rm -rf Vagrantfile
    brew cask uninstall vagrant > /dev/null 2>&1
    gem uninstall bundle > /dev/null 2>&1
    brew uninstall rbenv > /dev/null 2>&1
    ok "all clear - now run ./bin/dev.sh init again to spin up anew :)"
}

function reload_devenv() {
    export RELOAD=1
    rm -rf Vagrantfile
    thor devenv:vagrant
    vagrant reload --provision
}

function recreate() {
    rm -rf Vagrantfile
    rm -rf ./bin/install_vagrant_plugins.sh
    thor devenv:vagrant
    vagrant destroy -f
    vagrant up
}

case "$1" in
    init)
        init_devenv
        ;;
    purge)
        purge
        ;;
    start)
        vagrant up
        ;;
    reload)
        reload_devenv
        ;;
    recreate)
        recreate
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

