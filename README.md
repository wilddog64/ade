## Automated Desktop Environment (ADE)

Desktop environment configuration or management is always a beast.  It takes time to get your new machine into a state you like it to be.  When machine went south, it is also hard to get all the favior packages and configuration back.  This project is created to help on that perspective.

### \\[._.]/ - On OSX?
If you are running a mac, you might want to setup a better developer experience using [the dotfiles project](https://github.com/atomantic/dotfiles) before you begin.

### Getting Started

The simplest way to get started with a fresh new machine is to download this repository as a zip file (that's right, you don't even need git!). Then do the following:

- unzip the file
- in a command line (terminal for OSX, cygwin for Windows), cd into the folder
- run `./bin/dev init`

> NOTE: current support platforms are OSX, and Ubuntu Linux Distro (some packages from brew may not work)

### Requirements (installed via ./bin/dev init)

* Xcode and the command line tools

### Managing An Environment

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

#### brewcasks

brewcasks is a section that tells `brew cask` to install `OSX` specific DMG package.  This is an array, and it looks like this:

```
"brewcasks": [
    "google-chrome"
   ,"sourcetree"
   ,"firefox"
   ,"textmate"
   ,"virtualbox"
   ,"iterm2"
   ,"adium"
   ,"quicksilver"
   ,"vagrant"
   ,"cord"
   ,"controlplane"
   ,"hipchat"
   ,"keepassx"
],

```

#### gems
gems section tells `ade` what ruby-gem package you like to have for your development environment.  It is an array, and it looks like this:

```
"gems": [
    "os"
    ,"puppet"
    ,"facter"
    ,"chef"
    ,"berkshelf"
    ,"veewee"
    ,"boson"
    ,"alias"
    ,"hirb"
    ,"boson-more"
    ,"r10k"
    ,"librarian-puppet"
    ,"puppet-lint"
],
```

#### npms
The npm sections tells `ADE` what `node js` packages you like to be installed on your development environment.  It is an array, and it looks like this:

```
    "npms": [
        "azure"
       ,"azure-cli"
       ,"azure-completion"
       ,"azure-scripty"
       ,"azure-common"
       ,"sql-cli"
    ]
```

### Pull Request Additions to the Baseline

- fork this repo to your own github account or team
- git clone your fork
- add the original as an upstream remote `git remote add upstream git@github.disney.com:DTSS/ADE.git`
- make changes in a feature branch `git checkout -b my_feature; git commit -m 'my change'; git push -u origin my_feature`
- pull-request your feature branch to this repo



### Directory Structure

```
.
├── README.md                # this document
├── Thorfile                 # tells thor where to find its tasks
├── Vagrantfile              # a vagrant configuration file for building a test environment (linux ubuntu distro).
├── bin                      # all the magic stores here
│   ├── bootstrap.sh        # a library to detect os platform and install apporiate packages before anything can start
│   ├── console.sh          # a console output library
│   ├── dev                 # main script
│   ├── install_homebrew.sh # install brew before we can manage brew packages
│   ├── install_brewcask.sh # install brew-cask before we can install cask packages
│   ├── install_nodes.sh    # install node so we can use npm
│   ├── install_ruby.sh     # install ruby
│   ├── install_rbenv.sh    # install rbenv to manage ruby versions and gems
│   ├── lib.sh              # various shell functions
├── config.json              # a json configuration file to drive dev shell script
├── lib                      # a thor library
│   └── templates           # where thor uses to generate various shell scripts on the fly based on config.json
└── thor                     # a thor tasks directory
    └── dev.thor             # a thor tasks
```
