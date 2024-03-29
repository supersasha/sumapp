#!/bin/bash

function info(){ builtin echo [INFO] [$(basename $0)] $@; }
function error(){ builtin echo [ERROR] [$(basename $0)] $@; }


#. ${CLOUDIFY_LOGGING}
#. ${CLOUDIFY_FILE_SERVER}

TEMP_DIR="/tmp"


info "Changing directory to ${TEMP_DIR}"
cd ${TEMP_DIR} || exit $?

YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)


info "Downloading application sources to ${TEMP_DIR}"
if [ -d sumapp ]; then
    info "Application sources already exists, skipping"   
else
    if [[ ! -z $YUM_CMD ]]; then
        sudo yum -y install git-core || exit $?   
    elif [[ ! -z $APT_GET_CMD ]]; then 
        sudo apt-get -qq install git || exit $?   
    else
        error "error can't install package git"
        exit 1;
    fi

    info "cloning application from git url ${git_url}" 
    git clone ${git_url} || exit $?
    #cd sumapp || exit $?
    #if [[ ! -z $git_branch ]]; then
    #    info "checking out branch ${git_branch}" 
    #    git checkout ${git_branch} || exit $?
    #fi
fi

info "Installing pip"
sudo apt-get -qq install python-pip || exit $?

info "Installing flask"
sudo pip install flask || exit $?

info "Finished installing application ${app_name}"

