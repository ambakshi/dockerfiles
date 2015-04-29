FROM ubuntu


RUN apt-get update -y
RUN apt-get install -y \
            build-essential git subversion cmake python \
            bundler librpm-dev librpmbuild3 librpmsign1 rpm2cpio 

RUN mkdir /code
WORKDIR /code
ADD ./Makefile /code/
ADD ./Gemfile /code/
CMD ["make"]



