FROM gliderlabs/alpine:3.2

ENV UID=0 GID=0 USER=root GROUP=root LOGNAME=root HOME=/root SHELL=/bin/ash
WORKDIR /root

RUN apk-install openssl ca-certificates && rm /bin/tar
COPY tar-1.28 /bin/tar
RUN wget -qO - https://github.com/just-containers/s6-overlay/releases/download/v1.13.0.0/s6-overlay-amd64.tar.gz | tar zxf - -C /
ENTRYPOINT ["/init"]
CMD ["/bin/ash","-l"]
