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

function check_system_ruby() {
    which ruby
}

function check_brew_exist() {
    local brew_exists=0
    if [[ -e /usr/local/bin/brew ]]; then
	brew_exists=1
    fi

    echo $brew_exists
}

function install_required_gems() {

    if [[ -z check_system_ruby ]]; then
	bot 'Looks like you do not have brew on your system so I am working on it ...'	
    else
	require_gem facter 1 > /dev/null
	require_gem thor 1 > /dev/null
    fi
}

function get_os_platform() {
    install_required_gems

    local facter_bin=$(which facter)
    if [[ -z $facter_bin ]]; then
	error 'facter does not install script abort'
    fi
    $facter_bin os -y | ruby -ryaml -e "print YAML.load( STDIN.read )['os']['name']"	
}

function install_centos_brew() {
    action install prereq for centos
    sudo yum groupinstall 'Development Tools'
    ok
    sudo yum install curl git m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel
    ok
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

function install_centos_preq() {
    sudo yum groupinstall 'Development Tools' -y
    sudo yum install curl git m4 ruby texinfo bzip2-devel curl-devel expat-devel ncurses-devel zlib-devel -y
    echo PATH=~/.linuxbrew/bin:$PATH >> ~/.bashrc
    source ~/.bashrc
}



function install_ubuntu_preq() {
    sudo apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev -y
    echo PATH=~/.linuxbrew/bin:$PATH >> ~/.bashrc
    source ~/.bashrc
}

function install_linux_brew() {
    # ruby -e "$(wget -O- https://raw.github.com/Homebrew/linuxbrew/go/install)"
    install_brew https://raw.github.com/Homebrew/linuxbrew/go/install
}

function install_darwin_brew() {
    install_brew https://raw.githubusercontent.com/Homebrew/install/master/install
}

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
