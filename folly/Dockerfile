FROM ubuntu:trusty

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q -y && apt-get install -y \
	build-essential \
  	g++ \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
	libiberty-dev \
	git make
RUN apt-get install -y ruby-dev vim-nox tmux
RUN gem install --no-rdoc --no-ri fpm
RUN git clone https://github.com/facebook/folly /usr/src/folly && cd /usr/src/folly && git fetch --all
WORKDIR /usr/src/folly/folly
RUN autoreconf -ivf && ./configure && make -j`nproc`
RUN make DESTDIR=/tmp/folly install
RUN V=$(git describe --tags --abbrev=0 | sed -e 's/^v//g') && fpm -s dir -t deb --name folly --version $V --iteration ${ITERATION:-1} -C /tmp/folly usr
