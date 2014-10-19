## Mac Automated Desktop Environment (ADE)

Desktop environment configuration or management is always a beast.  It takes time to get your new machine into a state you like it too be.  When machine went south, it is also hard to get all the favior packages and configuration back.  This project is created to help on that perspective.


### Getting Started

The simplest way to get started with a fresh new machine is to download this repository as a zip file (that's right, you don't even need git!). Then do the following:

- unzip the file
- in a command line (terminal for OSX, cygwin for Windows), cd into the folder
- run `./bin/dev init`

> NOTE: current support platforms are OSX, and Ubuntu Linux Distro (some packages from brew may not work)

### Requirements (installed via ./bin/dev init)

* Xcode and the command line tools

### Managing Environment

```
# basic setup
git clone git@github.disney.com:DTSS/ADE.git;
cd ADE;
./bin/dev init               # initialze working environment, setup vagrant box, and build docker a base image

```

### Package Configuration

ADE uses config.json as a authoring sources to drive packages installation.  The config.json contains the following section,

#### vagrant-plugins
This section tells  `ADE` what `vagrant plugins` you like it to installed. The structure is like this,

```
    "vagrant_plugins": [
        {
            "name": "vagrant-omnibus",
            "options": ["config.omnibus.chef_version = :latest"],
            "version": ""
        },
        {
            "name": "vagrant-berkshelf",
            "options": ["config.berkshelf.enabled = true"],
            "version": "2.0.1"
        },
        {
            "name": "vagrant-cachier",
            "options": ["config.cache.enable :chef", "config.cache.enable :yum"],
            "version": ""
        }
       ,{
            "name": "vagrant-puppet-install",
            "option": ["config.puppet_install.puppet_version = :latest"],
            "version": ""
        }
    ],

```

vagrant-plugins is an array of hashes and each hash contains three keys,

* name is vagrant plugin name
* options is a list of plugin specific options that you like.  If no options require, simply provide an empty list like `[]`
* version is a desired plugin version like you.  If you want to use the latest one, just provide an empty string like `""`

#### brews

brews section describe what packages you want to install for your particular environment.  It is a list, and it looks like this:

```
"brews": [
    "zsh"
   ,"autojump"
   ,"colordiff"
   ,"macvim"
   ,"terminal-notifier"
   ,"rbenv-readline"
   ,"dtach"
   ,"curl"
   ,"git"
   ,"git-extras"
   ,"p7zip"
   ,"ctags"
   ,"dos2unix"
   ,"clib"
   ,"lynx"
   ,"coreutils"
   ,"tree"
   ,"maven"
   ,"gradle"
   ,"ssh-copy-id"
   ,"keychain"
   ,"packer"
   ,"docker"
   ,"boot2docker"
   ,"node"
   ,"gpg"
   ,"awscli"
],

```

### Pull Request Additions to the Baseline

- fork this repo to your own github account or team
- git clone your fork
- add the original as an upstream remote `git remote add upstream git@github.disney.com:DTSS/ADE.git`
- make changes in a feature branch `git checkout -b my_feature; git commit -m 'my change'; git push -u origin my_feature`
- pull-request your feature branch to this repo


### Create Your Own Docker Dev Setup!

- fork this repo into your own github profile or team account
- git clone your fork
- add the original as an upstream remote `git remote add upstream git@github.disney.com:DTSS/ADE.git`
- add files needed to build your nodes into the ./files directory
- add a script for each node you want to run locally in ./nodes
- commit and push to your own repo
- now new team members can download your fork, run `./bin/dev init` and be off running!


### Directory Structure

```
    .
    ├── Berksfile                 # Chef cookbooks managment files
    ├── Gemfile                   # Ruby Gems manage file
    ├── README.md                 # This document
    ├── Thorfile                  # Thor initialize file
    ├── bin                       # A directory contains various scripts related to environment/docker configuration
    │   ├── dev
    │   ├── devenv
    │   ├── devenv.rb
    │   ├── install_brewcask.sh
    │   ├── install_homebrew.sh
    │   ├── install_php.sh
    │   ├── install_ruby_gems.sh
    │   └── install_vagrant.sh
    ├── devenv.json              # A packer template
    ├── files                    # A directory for uploading files to container
    │   └── test.txt
    ├── lib                      # Thor library
    │   ├── Devenv
    │   └── templates
    ├── metadata.rb              # A chef metadata file
    ├── mount.json               # A json file that contains vagrant mount info
    ├── nodes                    # A directory contains scripts to build nodes
    │   └── php.sh
    ├── roles                    # A chef role for configuring and setup vagrant box
    │   └── bde_packer.json
    └── thor                     # Thor tasks directory
        └── dev.thor
```
