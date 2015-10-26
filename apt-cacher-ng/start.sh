#!/bin/bash
chmod 0777 /var/cache/apt-cacher-ng
service apt-cacher-ng start
sleep 1
exec tail -f /var/log/apt-cacher-ng/*
