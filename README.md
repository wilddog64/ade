Docker Dev Environment
======================
This readme file explains how to setup docker and use packer to build a docker container.

Requirement
-----------
* Vagrant >= 1.6.3      - to spin up and configure vagrant box to have packer and docker installed
* Berkshef >= 2.0.1     - for managing chef cookbooks
* Bundler               - for managing ruby gems

Running (OSX)
-------------
```
# assuming you've already setup homebrew:
# install chef/berkshelf/etc
brew cask install chefdk;
# install vagrant
brew cask install vagrant;
vagrant plugin install vagrant-omnibus;
vagrant plugin install vagrant-berkshelf --plugin-version 2.0.1;
vagrant reload --provison;
git clone git@github.disney.com:BDE-Chef/docker_devenv.git;
cd docker_devenv;
vagrant up;
```

Pull Request Additions
-------------
* fork this repo to your own github account or team
* git clone your fork
* add the original as an upstream remote `git remote add upstream git@github.disney.com:BDE-Chef/docker_devenv.git`
* make changes in a feature branch `git checkout -b my_feature; git commit -m 'my change'; git push -u origin my_feature`
* pull-request yourf feature branch to this repo


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
