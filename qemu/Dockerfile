FROM ubuntu:14.04.3
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive VERSION=2.4.0.1 LAST_UPDATE=10_25_2015

RUN apt-get update -y && apt-get install -y \
    build-essential curl git make libsdl-dev uuid-dev

RUN apt-get install -y   libncurses5-dev librbd-dev libaio-dev \
    libspice-server-dev libspice-protocol-dev \
    libusbredirhost-dev libcap-dev libattr1-dev \
    libjpeg-dev libpng12-dev flex bison perl libz-dev libbz2-dev
RUN apt-get install -y \
    ruby-dev liblzo2-dev
RUN gem install --no-rdoc --no-ri fpm
RUN mkdir /src && \
    cd /src && \
    curl http://wiki.qemu-project.org/download/qemu-${VERSION}.tar.bz2 | tar jxf - --strip-components 1

WORKDIR /build
RUN ../src/configure --prefix=/opt/qemu/qemu-$VERSION --enable-kvm --enable-vhdx --enable-tcmalloc \
			--enable-vnc --enable-curses --enable-virtfs --enable-linux-aio --enable-spice --enable-rbd \
			--enable-usb-redir --enable-lzo --enable-bzip2 --enable-vnc-jpeg --enable-vnc-png --enable-user \
			--enable-linux-user --enable-guest-agent --enable-guest-base --enable-sdl \
			--target-list="x86_64-softmmu"

#RUN cd /root && git clone https://git.kernel.org/pub/scm/virt/kvm/qemu-kvm.git
#ADD ./01-qemu-docs.patch /root/qemu-kvm/
#RUN cd /root/qemu-kvm && patch -p1 < 01-qemu-docs.patch
#WORKDIR /root/qemu-kvm
#RUN mkdir -p build && cd build && ../configure  --enable-sdl --enable-kvm --enable-vnc --enable-curses --enable-virtfs \
#                                                --enable-linux-aio --enable-spice --enable-rbd --enable-usb-redir \
#                                                --enable-vhost-net --enable-vnc-jpeg --enable-vnc-png \
#                                                --enable-user --enable-linux-user --enable-guest-agent \
#                                                --enable-guest-base --cpu=x86_64 --disable-werror \
#                                                --target-list=x86_64-softmmu --prefix=/opt/qemu-kvm
#
RUN make DESTDIR=/install -j8 install
RUN cd /install && fpm -s dir -t deb --provides qemu-kvm -n qemu-kvm --iteration 1 -v $VERSION opt/qemu/qemu-$VERSION

CMD ["/bin/bash","-c","cat /install/qemu-kvm_${VERSION}*.deb"]
