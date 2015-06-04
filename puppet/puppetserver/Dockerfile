FROM centos:centos6
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV PUPPET_VERSION 3.8.1

RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && \
    rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum install -y yum-utils epel-release cron-anacron tar rsyslog \
                   vim-enhanced bash-completion git hostname curl wget tar bzip2 && \
    yum-config-manager --enable centosplus
RUN yum install -y puppet-$PUPPET_VERSION  puppetserver puppetdb puppetdb-terminus
RUN yum clean all

RUN puppetserver gem install CFPropertyList && puppetserver gem install deep_merge
RUN gem install CFPropertyList && gem install deep_merge && gem install puppet-lint

RUN curl -o /usr/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" && chmod +x /usr/bin/gosu

RUN tar czf /root/puppetserver.tar.gz var/lib/puppet var/log/puppet var/log/puppetserver
RUN tar czf /root/puppetdb.tar.gz var/lib/puppetdb var/log/puppetdb

ADD puppet/puppet.conf /etc/puppet/puppet.conf
ADD puppet/hiera.yaml /etc/puppet/hiera.yaml
#VOLUME ["/opt/puppet"]
#RUN cp -rf /etc/puppet/* /opt/puppet/
#VOLUME ["/opt/varpuppet/lib/puppet"]
#RUN cp -rf /var/lib/puppet/* /opt/varpuppet/lib/puppet
#ENTRYPOINT ["/usr/bin/puppet","master","--no-daemonize","--verbose"]

ADD ./run /run
ADD puppetserver/logback.xml /etc/puppetserver/logback.xml
ADD puppetserver/sysconfig /etc/sysconfig/puppetserver
ENTRYPOINT ["/bin/bash","-e","/run"]
CMD ["puppetserver"]
