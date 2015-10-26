FROM debian:jessie
MAINTAINER Amit Bakshi <ambakshi@gmail.com> @ambakshi

RUN apt-get update && \
        DEBIAN_FRONTEND=noninteractive \
        apt-get install -y \
        apt-cacher-ng
ADD ./acng.conf /etc/apt-cacher-ng/
ADD ./start.sh /

EXPOSE 3142
VOLUME ["/var/cache/apt-cacher-ng"]
CMD ["/start.sh"]
