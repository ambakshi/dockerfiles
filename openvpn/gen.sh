#!/bin/bash

if [ -z "$1" ]; then
    echo >&2 "Specify clientname"
    exit 1
fi

export OVPN_DATA=openvpn_data_1
docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn easyrsa build-client-full "$1" nopass
docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_getclient "$1" > "${1}.ovpn"
chmod 0400 "${1}.ovpn"
