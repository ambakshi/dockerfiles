FROM centos:centos7
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum update -y && \
    yum groupinstall -y 'Development Tools' && \
    yum install -y libX11-devel freetype-devel zlib-devel libxcb-devel epel tar bzip2 vim-enhanced git curl
RUN curl -sSL http://prdownloads.sourceforge.net/wine/wine-1.7.50.tar.bz2 | tar jxf - -C /usr/src
WORKDIR /usr/src/wine-1.7.50
RUN ./configure --enable-win64
RUN make -j8
RUN make install
RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.16.0.0/s6-overlay-amd64.tar.gz | tar zxf - -C /
RUN mkdir -m 0700 -p /root/.ssh
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 0600 /root/.ssh/authorized_keys
RUN yum install -y openssh-server openssh
EXPOSE 22
ENTRYPOINT ["/init"]
CMD ["/usr/sbin/sshd","-D"]


