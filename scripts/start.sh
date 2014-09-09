#!/bin/bash

function info(){ builtin echo [INFO] [$(basename $0)] $@; }
function error(){ builtin echo [ERROR] [$(basename $0)] $@; }


#. ${CLOUDIFY_LOGGING}
#. ${CLOUDIFY_FILE_SERVER}

TEMP_DIR="/tmp"

info "Starting ${app_name}"
nohup python ${TEMP_DIR}/${app_name}/sumapp.py ${base_port} > /dev/null 2>&1 &

info "Started ${app_name}"
