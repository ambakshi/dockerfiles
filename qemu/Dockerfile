FROM ubuntu:latest
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive VERSION=2.4.0.1

RUN apt-get update && apt-get install -y \
    build-essential curl git make libsdl-dev uuid-dev \
    libncurses5-dev libcephfs-dev librbd-dev libaio-dev \
    libgoogle-perftools-dev libspice-server-dev libspice-protocol-dev \
    libusbredirhost-dev libnfs-dev libcap-dev libattr1-dev \
    libjpeg-dev libpng12-dev flex bison texinfo perl libz-dev libbz2-dev
RUN cd /root && curl http://wiki.qemu-project.org/download/qemu-${VERSION}.tar.bz2 | tar jxf -
WORKDIR /root/qemu-$VERSION
RUN ./configure --prefix=/opt/qemu-$VERSION --enable-sdl --enable-kvm --enable-vhdx --enable-tcmalloc --enable-vnc --enable-curses --enable-virtfs --enable-linux-aio --enable-spice --enable-rbd --enable-usb-redir --enable-bzip2 --enable-vnc-jpeg --enable-vnc-png --enable-system --enable-user --enable-linux-user --enable-guest-agent --enable-guest-base --enable-docs
VOLUME ["/opt"]
CMD ["make","-j8","install"]

