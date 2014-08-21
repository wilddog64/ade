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

    platform=`uname`
    running "checking OS compatibility"
    if [[ "$platform" == "Darwin" ]]; then
        ok
        ./scripts/osx_setup.sh
        install_homebrew
        install_brewcask
    elif [[ "$platform" == "cygwin" ]]; then
        error "This setup is not yet tested on cygwin. Please pull request updates!"
    else
        error "Sorry, your environment is unsupported. Please order a macbook :)"
		exit -1
    fi

    # (~/src will be automatically shared into dev nodes)
    # safely make it if it doesn't exist
    mkdir -p ~/src

    require_cask vagrant
    install_all_rubygems

    running "generate config files"
    # remove generated files
    rm -rf Vagrantfile
    # create new Vagrantfile from template
    thor devenv:vagrant
    ok

    source ./bin/install_vagrant_plugins.sh
    install_vagrant_plugins

    if [[ $reload = 1 ]]; then
        running "reloading vagrant"
        vagrant reload --provision
        ok
    else
        echo "starting vagrant..."
        vagrant up
        ok
    fi
}

function purge() {
    vagrant halt > /dev/null 2>&1
    rm -rf Vagrantfile
    rm -rf ./bin/install_vagrant_plugins.sh
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

