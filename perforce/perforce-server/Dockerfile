FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y perforce-server
# RUN mkdir -p -m 0700 /data/p4root && touch /data/{empty.txt,p4root/empty.txt} && chown perforce:perforce /data/{empty.txt,p4root/empty.txt}
VOLUME /data
EXPOSE 1666
ADD ./run.sh  /
ENTRYPOINT ["/run.sh"]
