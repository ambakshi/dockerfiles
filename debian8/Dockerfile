FROM debian:jessie
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive HOME=/root

RUN apt-get update && apt-get install -q -y --no-install-recommends locales && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN dpkg-reconfigure locales && locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https ca-certificates netcat net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        curl bzip2 hostname wget cron tar rsyslog \
        vim-nox bash-completion git build-essential \
        apt-utils ca-certificates openssl && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -o /usr/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" && chmod +x /usr/bin/gosu
RUN curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/v1.13.0.0/s6-overlay-amd64.tar.gz" | tar zxf - -C /
RUN /bin/echo -ne 'set nocompatible\nset backspace=eol,start,indent\nsyntax on\nfiletype indent on\nset autoindent\ncolorscheme desert\nset nobackup\nnnoremap ; :\n\n' > /etc/vim/vimrc.local


ENTRYPOINT ["/init"]
CMD ["/bin/bash","-l"]
