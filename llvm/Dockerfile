FROM debian:sid
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN apt-get update -y
RUN apt-get install -y build-essential git subversion cmake bundler
RUN apt-get install -y librpm-dev librpmbuild3 librpmsign1 rpm2cpio 
RUN ln -s plat-x86_64-linux-gnu/_sysconfigdata_nd.py /usr/lib/python2.7/
RUN apt-get install -y apt-utils
RUN apt-get install -y python
RUN mkdir /code
WORKDIR /code
ADD ./Makefile /code/
ADD ./Gemfile /code/
CMD ["make"]



