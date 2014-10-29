#!/bin/sh
if [ $1 = 0 ]; then
    /usr/sbin/update-alternatives --remove go /usr/local/go/bin/linux_amd64/go
fi
