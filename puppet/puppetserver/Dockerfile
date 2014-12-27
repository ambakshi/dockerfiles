FROM centos:centos7
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN rpm -Uvh http://yum.puppetlabs.com/el/7/products/x86_64/puppetlabs-release-7-11.noarch.rpm
RUN yum install -y epel-release
RUN yum install -y puppetserver vim-enhanced bash-completion git
EXPOSE 8140
VOLUME ["/var/lib/puppet"]
RUN puppet config set --section master autosign true
WORKDIR /var/lib/puppet
ADD ./puppetserver.sh /run.sh
ADD ./puppetserver.logback.xml /etc/puppetserver/logback.xml
ADD ./puppetserver.sysconfig /etc/sysconfig/puppetserver
CMD ["/usr/sbin/runuser","-u","puppet","/run.sh"]
