Docker Dev Environment
======================
This readme file explains how to setup docker and use packer to build a docker container.

Requirement
-----------
* Vagrant 1.6.3 - to spin up and configure vagrant box to have packer and docker installed
* Berkshef      - for managing chef cookbooks
* Bundler       - for managing ruby gems

Running (OSX)
--------------
```
# assuming you've already setup homebrew:
# install chef/berkshelf/etc
brew cask install chefdk;
# install vagrant
brew cask install vagrant;
git clone git@github.disney.com:BDE-Chef/docker_devenv.git;
cd docker_devenv;
vagrant up;
```

Directory Structure
-------------------
```
    .
    ├── Berksfile                   # Chef cookbooks managment file
    ├── Berksfile.lock
    ├── Gemfile                     # Ruby Gems managment file
    ├── Gemfile.lock
    ├── README.md                   # This document
    ├── Vagrantfile
    ├── bin                         # a directory cotains various scripts to configure a given docker container
    │   └── install_php.sh
    ├── devenv.json                 # packer template
    ├── metadata.rb                 # a chef metadata file
    └── roles                       # a chef role directory
        └── bde_packer.json         # a role to install packer into a vagrant box
```
