#!/bin/bash

set -e

test -f /etc/ssh/ssh_host_rsa_key || ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
test -f /etc/ssh/ssh_host_dsa_key || ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ""
mkdir -p -m 0700 /var/run/sshd
