FROM centos:7
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum update -y && yum install -y tar bzip curl
RUN curl -sSL https://d1ilhw0800yew8.cloudfront.net/client/dropbox-lnx.x86_64-3.8.9.tar.gz | tar zxf - -C /opt
RUN mv /opt/.dropbox-dist/ /opt/dropbox
CMD ["/opt/dropbox/dropboxd"]
