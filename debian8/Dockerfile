FROM debian:jessie
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN DEBIAN_FRONTENT=noninteractive apt-get update && \
    DEBIAN_FRONTENT=noninteractive apt-get install -y -q --no-install-recommends \
        curl bzip2 hostname wget cron tar rsyslog \
        vim-nox bash-completion git build-essential \
        apt-utils ca-certificates openssl

RUN curl -o /usr/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" && chmod +x /usr/bin/gosu
RUN curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v1.13.0.0/s6-overlay-amd64.tar.gz" | tar zxf - -C /
RUN /bin/echo -ne 'set nocompatible\nset backspace=eol,start,indent\nsyntax on\nfiletype indent on\nset autoindent\ncolorscheme desert\nset nobackup\nnnoremap ; :\n\n' > /etc/vim/vimrc.local

ENV HOME=/root
WORKDIR /root

ENTRYPOINT ["/init"]
CMD ["/bin/bash","-l"]
