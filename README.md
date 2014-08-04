Automated Development Environments (ADE)
======================
This project will install, configure and run a development environment using Vagrant and Docker instances.

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

./bin/dev.sh init               # initialze working environment, setup vagrant box, and build docker a base image
./bin/dev.sh start              # only spin up vagrant box and a build docker base image
./bin/dev.sh reload             # restart vagrant box and rebuild a docker base image
./bin/dev.sh recreate           # cleanup vagrant environment and rebuild everything
```

Configure Mount Directories
-----------------------
If you need to mount directories into your node(s), you can add mount locations to mount.json
By default, we will mount ~/src, assuming all your git repos are cloned under that path (if not, you can ln -s /path/to/git/repos ~/src).

You can or modify mount points in the mount.json file like so

```
    {
        "vagrant_mounts": [
            {
                "path": "~/src",
                "mount_point": "/tmp/vagrant/src"
            },
            {
                "path": "~/my/awesome/path",
                "mount_point": "/tmp/vagrant/otherstuff"
            }
        ]
    }

```

* path is the location of the folder on your native host
* mount_point is a mount directory inside a vagrant box, which you can use in your /node/* scripts when setting up your nodes
* these directories will be mounted on all nodes (in case you are building a multi-node project)

Pull Request Additions to the Baseline
-------------
* fork this repo to your own github account or team
* git clone your fork
* add the original as an upstream remote `git remote add upstream git@github.disney.com:BDE-Chef/docker_devenv.git`
* make changes in a feature branch `git checkout -b my_feature; git commit -m 'my change'; git push -u origin my_feature`
* pull-request your feature branch to this repo


Create Your Own Docker Dev Setup!
----------
* fork this repo into your own github profile or team account
* git clone your fork
* add the original as an upstream remote `git remote add upstream git@github.disney.com:BDE-Chef/docker_devenv.git`
* add files needed to build your nodes into the ./files directory
* add a script for each node you want to run locally in ./nodes
* commit and push to your own repo
* now new team members can download your fork, run `./bin/dev init` and be off running!


Directory Structure
-------------------
```
    .
    ├── Berksfile                 # Chef cookbooks managment files
    ├── Gemfile                   # Ruby Gems manage file
    ├── README.md                 # This document
    ├── Thorfile                  # Thor initialize file
    ├── bin                       # A directory contains various scripts related to environment/docker configuration
    │   ├── dev.sh
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
