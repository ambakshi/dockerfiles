FROM centos:centos6
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum update -y && \
    yum groupinstall -y 'Development tools' && \
    yum install -y tar gzip cronolog rsyslog ruby ruby-devel rubygems vim-enhanced \
    epel-release sudo hg bash-completion bzr rpmdevtools rpm-build rpm-libs \
    openssh openssh-server openssh-clients screen mysql-server mysql httpd php
RUN gem install --no-rdoc --no-ri fpm
RUN rpm -Uvh http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-13.ius.centos6.noarch.rpm
RUN yum -y install yum-plugin-replace
RUN yum replace --enablerepo='ius*' -y git --replace-with git18
RUN mkdir -p -m 0700 /root/.ssh && touch /root/.ssh/authorized_keys && chmod 0600 /root/.ssh/authorized_keys
RUN groupadd -g 1000 dev && useradd -u 1000 -g dev -m -s /bin/bash dev
RUN runuser -l dev -c 'ssh-keygen -q -f ~/.ssh/id_rsa -N ""'
RUN cat /home/dev/.ssh/*.pub >> /root/.ssh/authorized_keys
#RUN echo '@SSH_PUB_KEY@' >> /root/.ssh/authorized_keys
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
RUN sed -i 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su
EXPOSE 22 80 443 3306
RUN printf '#!/bin/bash -e\n%s\n' 'service sshd start; service mysqld start; /usr/sbin/httpd -DFOREGROUND' > /base.sh && chmod +x /base.sh
CMD ["/bin/bash","-e","/base.sh"]
ADD ./authorized_keys /root/.ssh/authorized_keys_lc
RUN cat /root/.ssh/authorized_keys_lc >> /root/.ssh/authorized_keys

