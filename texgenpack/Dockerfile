FROM centos:centos7
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum update -y && yum groupinstall -y 'Development tools' && yum install -y epel-release libpng-devel libjpeg-devel
RUN git clone https://github.com/hglm/libfgen.git /src/libfgen
RUN make -C /src/libfgen install
RUN git clone https://github.com/hglm/texgenpack.git /src/texgenpack
RUN make -C /src/texgenpack || test -f /src/texgenpack/texgenpack
RUN cp /src/texgenpack/texgenpack /usr/bin
RUN ldconfig
VOLUME /data
ENTRYPOINT ["/usr/bin/texgenpack"]
