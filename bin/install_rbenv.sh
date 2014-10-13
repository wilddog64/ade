function init_rbenv() {
    running "init rbenv"
    local rcfile=$1
    local rc=0

    if [[ ! -e $rcfile ]]; then
    	action "$rcfile does not exist, creating"
        touch $rcfile
        ok
    fi

    which rbenv > /dev/null
    if [[ $? != 0 ]]; then
        if [[ $(grep rbenv $rcfile) ]]; then
            action "populating rcfile with rbenv init"
            echo 'eval "$(rbenv init -)"' >> $rcfile
            action "resourcing rcfile"
            source ~/.bashrc
        fi
    fi
    ok

    action 'install ruby-build'
    require_brew ruby-build
    if [[ $? != 0 ]]; then
        error "unable to install ruby-build"
        exit -1
    fi
    ok
}

function install_rbenv() {
    require_brew rbenv
    require_brew ruby-build
    init_rbenv ~/.bashrc
}

function rbenv_rehash() {
    action 'rehash rbenv'
    eval "$(rbenv init -)"
}
