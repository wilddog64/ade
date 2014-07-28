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
git clone git@github.disney.com:BDE-Chef/docker_devenv.git;
cd docker_devenv;
./bin/dev init;
```

Pull Request Additions to the Baseline
-------------
* fork this repo to your own github account or team
* git clone your fork
* add the original as an upstream remote `git remote add upstream git@github.disney.com:BDE-Chef/docker_devenv.git`
* make changes in a feature branch `git checkout -b my_feature; git commit -m 'my change'; git push -u origin my_feature`
* pull-request your feature branch to this repo


Create Your Own Docker Dev Setup!
----------
# fork this repo into your own github profile or team account
# git clone your fork
# add the original as an upstream remote `git remote add upstream git@github.disney.com:BDE-Chef/docker_devenv.git`
# add files needed to build your nodes into the ./files directory
# add a script for each node you want to run locally in ./nodes
# commit and push to your own repo
# now new team members can download your fork, run `./bin/dev init` and be off running!


Directory Structure
-------------------
```
    .
    ├── Berksfile                   # Chef cookbooks managment file
    ├── Gemfile                     # Ruby Gems managment file
    ├── README.md                   # This document
    ├── Vagrantfile
    ├── bin                         # a directory cotains various scripts to configure a given docker 
    │   ├── config_homebrew.sh
    │   └── dev
    ├── devenv.json                 # packer template
    ├── files                       # all files in ./files will be mounted on the docker nodes
    │   └── test.txt
    ├── metadata.rb                 # a chef metadata file
    ├── nodes                       # each script in this directory will create a docker node
    │   └── php.sh                  # php installation script
    └── roles                       # a chef role directory
```
