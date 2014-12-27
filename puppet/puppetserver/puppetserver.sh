#!/bin/bash -e
#
# taken from the systemd unit file
#

. /etc/sysconfig/puppetserver

exec /usr/bin/java $JAVA_ARGS \
          -XX:OnOutOfMemoryError=kill\ -9\ %p \
          -XX:+HeapDumpOnOutOfMemoryError \
          -XX:HeapDumpPath=/var/log/puppetserver \
          -Djava.security.egd=/dev/urandom \
          -cp "${INSTALL_DIR}/puppet-server-release.jar" clojure.main \
          -m puppetlabs.trapperkeeper.main \
          --config "${CONFIG}" \
          -b "${BOOTSTRAP_CONFIG}" "$@"
