FROM debian:sid
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

## This is a fix for Debian Sid.
RUN ln -s plat-x86_64-linux-gnu/_sysconfigdata_nd.py /usr/lib/python2.7/

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y build-essential git subversion cmake \
                       librpm-dev librpmbuild3 librpmsign1 rpm2cpio rpm \
                       python2.7 ninja-build bundler
ENV CLANG_VERSION=3.7 BUILD_NUMBER=0
VOLUME ["/usr/src","/code/build","/pkg"]
RUN mkdir /code
WORKDIR /code
ADD ./Makefile /code/
ADD ./Gemfile /code/
CMD ["make"]
