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

RUN apt-get install -y --no-install-recommends ruby-dev vim-nox liblzo2-dev
WORKDIR /root/qemu-$VERSION/build
RUN ../configure --prefix=/opt/qemu-$VERSION --enable-kvm --enable-vhdx --enable-tcmalloc \
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

CMD ["make","-j8","install"]

