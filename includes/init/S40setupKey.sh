#!/bin/bash

RTD_USER_HOME="/home/rtd"

/bin/mkdir -p ${RTD_USER_HOME}/.ssh

/bin/chown -R rtd:rtd ${RTD_USER_HOME}/.ssh
/bin/chmod u=rwX,g=,o= ${RTD_USER_HOME}/.ssh

if [[ -f "${RTD_USER_HOME}/.ssh/id_rsa.pub" ]]; then
    /bin/chmod u=rw,g=,o= ${RTD_USER_HOME}/.ssh/*
    echo "### Git Public Key ###"
    echo ""
    cat ${RTD_USER_HOME}/.ssh/id_rsa.pub
    echo ""
    echo ""
    echo "######################"
else
    echo "[WARN] No SSH keys found ${RTD_USER_HOME}/.ssh"
    echo "[WARN] SSH connectivity will not be possible."
fi