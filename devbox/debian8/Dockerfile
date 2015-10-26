FROM debian:latest
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

RUN apt-get update -q -o Acquire::Pdiffs=false
RUN apt-get install -qy locales
RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN dpkg-reconfigure locales

## This is a fix for Debian Sid.
RUN ln -s plat-x86_64-linux-gnu/_sysconfigdata_nd.py /usr/lib/python2.7/

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential git subversion cmake \
                       librpm-dev librpmbuild3 librpmsign1 rpm2cpio rpm \
                       python2.7 ninja-build bundler libncurses5-dev \
                       xfsprogs btrfs-tools htop vim-nox bash-completion \
                       curl ctags tmux openssh-server
RUN curl -sSL http://bit.ly/devbootstrap > /usr/bin/devbootstrap.sh && chmod +x /usr/bin/devbootstrap.sh
RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.14.0.4/s6-overlay-amd64.tar.gz | tar zxf - -C /
RUN groupadd -g 1000 vagrant && useradd -u 1000 -g vagrant -m -s /bin/bash vagrant && gpasswd --add vagrant sudo
RUN mkdir -p -m 0700 /home/vagrant/.ssh && curl -fsSL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub >> /home/vagrant/.ssh/authorized_keys && chmod 0600 /home/vagrant/.ssh/authorized_keys && chown -R vagrant:vagrant /home/vagrant
RUN echo '%sudo         ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN echo "[ \$UID -eq 0 ] && PS1='\[\e[31m\]\h:\w#\[\e[m\] ' || PS1='[\[\033[32m\]\u@\h\[\033[00m\] \[\033[36m\]\W\[\033[31m\]\$(__git_ps1)\[\033[00m\]] \$ '"  | tee /etc/bash_completion.d/prompt
RUN apt-get install -y rsyslog cron
RUN mkdir -p /etc/services.d/sshd /etc/services.d/cron /etc/services.d/rsyslog
RUN printf '#!/usr/bin/execlineb -P\n/usr/sbin/sshd -D\n' > /etc/services.d/sshd/run && chmod +x /etc/services.d/sshd/run
RUN printf '#!/usr/bin/execlineb -P\n/usr/sbin/cron\n' > /etc/services.d/cron/run && chmod +x /etc/services.d/cron/run
RUN printf '#!/usr/bin/execlineb -P\n/usr/sbin/rsyslogd -n\n' > /etc/services.d/rsyslog/run && chmod +x /etc/services.d/rsyslog/run

ADD ./02-sshd-init.sh /etc/cont-init.d/
EXPOSE 22 80 443 8080
ENTRYPOINT ["/init"]
CMD ["/bin/bash","-l"]
