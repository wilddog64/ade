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

Configure Vagrant Mount
-----------------------
Vagrantfile are generated on the fly via template, which also included mounting local folder into a given vagrant box.
This is controlled by mount.json. To add a new mounted folder to a vagrant box, open ./mount.json and  add a json hash that contains ```path```,
and ```mount_point``` to this.

```
    {
        "vagrant_mounts": [
            {
                "path": "~/src/gitrepo/disney/DisneyID_UI/",
                "mount_point": "/tmp/vagrant/DisneyID_UI"
            },
            {
                "path": "~/src/gitrepo/disney/DisneyID_L10n_Content/",
                "mount_point": "/tmp/vagrant/DisneyID_L10n_Content"
            }
        ]
    }

```

* path is a physical path to the folder you want to mount
* mount_point is a mount directory inside a vagrant box

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
