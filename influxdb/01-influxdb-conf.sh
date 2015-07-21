#!/bin/bash
if [ ! -e /influxdb/influxdb.conf ]; then
    sed -e 's/@HOSTNAME@/'$HOSTNAME'/g' -e 's@/var/opt/influxdb@'$PWD'@g' /influxdb/influxdb.conf.tpl > /influxdb/influxdb.conf
fi
chown influxdb:influxdb /influxdb/influxdb.conf
