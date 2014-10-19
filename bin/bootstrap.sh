#!/usr/bin/env bash

# use system ruby

function _getScriptDir() {
    unset CDPATH               # so this script won't be affect by CDPATH variable
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      SOURCE="$(readlink "$SOURCE")"
      # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    echo "$( cd -P "$( dirname "$SOURCE" )" && pwd )"
}

# figure where this script located
SCRIPT_HOME=$(dirname $(_getScriptDir))
SCRIPT_BIN=$SCRIPT_HOME/bin

cd $SCRIPT_HOME
source $SCRIPT_BIN/console.sh
source $SCRIPT_BIN/lib.sh

# check_system_ruby is used to find out where is ruby for a given
# system
function check_system_ruby() {
    which ruby
}

# check_brew_exist checks if brew exists for any
# given environment
function check_brew_exist() {
    local brew_exists=0
    if [[ -e /usr/local/bin/brew ]]; then
	brew_exists=1
    fi

    echo $brew_exists
}

# install_required_gems will install some gems that are used
# by dev shell script. In this case facter and thor.
function install_required_gems() {

    if [[ -z check_system_ruby ]]; then
	bot 'Looks like you do not have required gems thor and facter on your system so I am going to get it form you ...'	
    else
       require_gem facter 1 > /dev/null
       require_gem thor 1 > /dev/null
    fi
}

# get_os_platform check os platform when
# script run.  This function depends on 
# facter for such functionality.  The facter installation
# is done by install_required_gems
function get_os_platform() {
    install_required_gems

    local facter_bin=$(which facter)
    if [[ -z $facter_bin ]]; then
       error 'facter does not install script abort'
    fi
    $facter_bin os -y | ruby -ryaml -e "print YAML.load( STDIN.read )['os']['name']"	
}


function install_homebrew() {
    local platform_name=$(get_os_platform)

    case $platform_name in
	CentOS*)
	    echo platform is $platform_name
	    install_centos_preq
	    install_linux_brew
	    ;;
	Ubuntu*)
	    echo platform is $platform_name
	    install_ubuntu_preq
	    install_linux_brew
	    ;;
	Darwin*)
	    echo platform is $platform_name
	    install_darwin_brew
    esac
}

# install_centos_preq install all the necessary centos packages before 
# install homebrew
function install_centos_preq() {
    sudo yum groupinstall 'Development Tools' -y
    sudo yum install curl git m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel -y
    add_homebrew_path
    source ~/.bashrc
}

# install_ubuntu_preq install all the necessary ubuntu packages
# before installing homebrew
function install_ubuntu_preq() {
    sudo apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev -y
    add_homebrew_path
    source ~/.bashrc
}

# add homebrew path into .bashrc
function add_homebrew_path() {
    if [[ $(grep linuxbrew ~/.bashrc) != 0 ]]; then
        echo PATH=~/.linuxbrew/bin:$PATH >> ~/.bashrc
    fi
}

# install_linux_brew takes care of install homebrew for linux OSes
function install_linux_brew() {
    # ruby -e "$(wget -O- https://raw.github.com/Homebrew/linuxbrew/go/install)"
    install_brew https://raw.github.com/Homebrew/linuxbrew/go/install
}

# install_darwin_brew installs homebrew for OSX
function install_darwin_brew() {
    install_brew https://raw.githubusercontent.com/Homebrew/install/master/install
}

# install_brew is the main entry for taking care of brew installation
function install_brew() {
    local brew_url=$1
    running "checking homebrew"
    brew_bin=$(which brew) 2>&1 > /dev/null
    if [[ $? != 0 ]]; then
        action "installing homebrew"
        ruby -e "$(curl -fsSL $brew_url)"
        if [[ $? != 0 ]]; then
            error "unable to install homebrew, script $0 abort!"
            exit -1
        fi
    fi
    ok
}
