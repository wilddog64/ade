#!/bin/bash

set -e

# vagrant up


SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

cd $SCRIPT_HOME/..

case "$1" in
	init)
		# install vagrant
		# git clone all repos
		# vagrant up (with /files mounted)
		# provision a machine per shell scrips in /nodes
		# check for homebrew then
		brew cask install chefdk;
		brew cask install vagrant;
		vagrant plugin install vagrant-omnibus;
		vagrant plugin install vagrant-berkshelf --plugin-version 2.0.1;
		vagrant reload --provison;
		vagrant up;
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