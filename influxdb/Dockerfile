FROM debian:jessie

RUN export DEBIAN_INTERACTIVE=no && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
        curl vim-nox ca-certificates
RUN curl -sSL -O https://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb
RUN dpkg -i influxdb_latest_amd64.deb && rm -f influxdb_latest_amd64.deb
RUN curl -o /usr/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" && chmod +x /usr/bin/gosu
RUN curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz" | tar zxf -
RUN mkdir -p /etc/cont-init.d /etc/fix-attrs.d
RUN mkdir -p -m 0755 /influxdb/meta /influxdb/data /influxdb/hh && chown -R influxdb:influxdb /influxdb
COPY influxdb.conf.tpl /influxdb/
COPY 01-influxdb-conf.sh /etc/cont-init.d/
COPY 01-influxdb-dirs.txt /etc/fix-attrs.d/
WORKDIR /influxdb
EXPOSE 8088 8083 8086
ENV HOME=/influxdb
ENTRYPOINT ["/init"]
CMD ["gosu", "influxdb","/opt/influxdb/influxd","-config","/influxdb/influxdb.conf"]
