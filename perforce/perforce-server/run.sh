#!/bin/bash

export P4ROOT="${P4ROOT:-/data/p4root}"
export P4SSLDIR="${P4SSLDIR:-/etc/perforce/sslkeys}"
export P4PORT="${P4PORT:-1666}"

mkdir -m 0700 -p $P4ROOT $P4SSLDIR
chown perforce:perforce $P4ROOT $P4SSLDIR
cd /opt/perforce/servers
cat > /opt/perforce/servers/.profile <<EOF
export P4ROOT=$P4ROOT
export P4PORT=$P4PORT
export P4SSLDIR=$P4SSLDIR
EOF

if [ ! -e "$P4SSLDIR/privatekey.txt" ]; then
    runuser -l perforce -c "/opt/perforce/sbin/p4d -Gc"
fi

exec runuser -l perforce -c "/opt/perforce/sbin/p4d $*"
