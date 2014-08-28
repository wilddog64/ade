#!/usr/bin/env bash

source ./bin/lib.sh


# Ask for the administrator password upfront
bot "Please enter your sudo password (same as your login password) so I can work unimpeded:"
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# This is the main OSX setup script for your team
# it will be automatically run when someone runs `./bin/dev.sh init` on OSX

# TODO: git clone projects into ~/src
# ...

# example: install a whole configuration and default software set for OSX
# git clone --recurse-submodules https://github.com/atomantic/dotfiles ~/.dotfiles
# cd ~/.dotfiles
# ./install.sh

running "testing /etc/hosts for local entries"
grep desktop.framework.corp.disney.com /etc/hosts
if [[ $? != 0 ]]; then
	action "adding hosts file entries"
	sudo chown $(whoami) /etc/hosts
	echo -e "\n127.0.0.1 desktop.framework.corp.disney.com" >> /etc/hosts
	# if the user is running cisco anyconnect VPN software, they will have a special
	# /etc/hosts.ac file that copies back over /etc/hosts periodically
	sudo chown $(whoami) /etc/hosts.ac
	echo -e "\n127.0.0.1 desktop.framework.corp.disney.com" >> /etc/hosts.ac
fi
ok


if [ ! -d ~/ade/src/portal ]; then
	# get the code repo
	git clone git://github.disney.com/Portal/portal_application_framework.git ~/ade/src/portal
	cd ~/ade/src/portal
	./deploy.sh -b master -l
	cd -
fi

# all done