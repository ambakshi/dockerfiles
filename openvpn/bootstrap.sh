#!/bin/bash
OVPN_DATA=openvpn_data_1
SERVER='dc.atvict.com'


docker-compose up -d data

docker run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_genconfig -u udp://$SERVER
docker run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn ovpn_initpki

docker-compose up -d ca

