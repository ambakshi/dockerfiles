#!/bin/bash
SCRIPT=$(basename $0)
export JAVA_HOME="${JAVA_HOME:-/usr/lib/jvm/jre}"
export HADOOP_HOME="$(cd $(dirname ${BASH_SOURCE[0]})/../share/java/hadoop && pwd)"
export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native"
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$PATH
exec $HADOOP_HOME/bin/$SCRIPT "$@"
