## 
## Build: curl -fsSL https://gist.githubusercontent.com/ambakshi/51c994271a216016edef/raw/Dockerfile | docker build -t ambakshi/devbox -
##

FROM centos:centos6
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV DEBIANT_FRONTEND=noninteractive
RUN yum update -y && yum install -y epel-release man which
RUN rpm -Uvh http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-14.ius.centos6.noarch.rpm
## RUN yum groupinstall -y 'Development tools'

RUN yum update -y && yum install -y tar gzip ruby ruby-devel rubygems python python-devel hg ctags-etags \
    sudo bash-completion curl gcc gcc-c++ make openssh openssh-server openssh-clients git2u rpmdevtools rpm-build rpm-libs
RUN yum localinstall -y \
             http://yum.baksh.io/el/6/x86_64/vim-7.4-1.x86_64.rpm \
             http://yum.baksh.io/el/6/x86_64/tmux-2.1-4.x86_64.rpm

## Fix up some settings to allow sudo/su without docker's terminal
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
    sed -i 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su && \
    sed -i 's@^Defaults\([ ]*\)requiretty$@#Defaults\1requiretty@g' /etc/sudoers
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel && chmod 0400 /etc/sudoers.d/wheel
RUN echo 'gem: --no-rdoc --no-ri' > /etc/gemrc

RUN ln -sfn /usr/share/git-core/contrib/completion/git-prompt.sh /etc/bash_completion.d
RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs && rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum install -y puppet
         
### This step can be skipped since git went to v2 we install it directly
## RUN yum -y install yum-plugin-replace git
## RUN yum replace --enablerepo='ius*' -y git --replace-with git2u
## RUN yum install -y git2u
RUN yum clean all


## Golang 1.4.2
RUN curl -fsSL https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar xzf - -C /usr/local
ENV PATH=$PATH:/usr/local/go/bin

RUN gem install fpm
RUN gem install bundler

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N "" && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ""
RUN mkdir -p -m 0700 /root/.ssh && touch /root/.ssh/authorized_keys && chmod 0600 /root/.ssh/authorized_keys
RUN groupadd -g 1000 vagrant && useradd -u 1000 -g vagrant -m -s /bin/bash vagrant && gpasswd --add vagrant wheel
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.9.1.3/s6-overlay-amd64.tar.gz /tmp/
RUN tar zxf /tmp/s6-overlay-amd64.tar.gz -C /
ENV HOME=/home/vagrant
WORKDIR $HOME
USER vagrant
EXPOSE 22 80 443 8080
RUN mkdir -p -m 0700 $HOME/.ssh && curl -fsSL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub >> $HOME/.ssh/authorized_keys && chmod 0600 $HOME/.ssh/authorized_keys
RUN curl -fsSL https://gist.githubusercontent.com/ambakshi/51c994271a216016edef/raw/bootstrap.sh | /bin/bash -e
RUN echo "PS1='[\[\033[32m\]\u@\h\[\033[00m\] \[\033[36m\]\W\[\033[31m\]\$(__git_ps1)\[\033[00m\]] \$ '" >> $HOME/.bashrc
RUN echo "export GOPATH=$HOME" >> $HOME/.bashrc
RUN echo "export PATH=\"$PATH:/usr/local/go/bin:$HOME/bin\"" >> $HOME/.bashrc
RUN GOPATH=$HOME vim -T dumb +GoInstallBinaries +qa!
# ONBUILD RUN ssh-keygen -q -f ~/.ssh/id_rsa -N "" && cat $HOME/.ssh/*.pub | sudo tee -a /root/.ssh/authorized_keys
# ONBUILD ADD ./authorized_keys /tmp/authorized_keys
# ONBUILD RUN cat /tmp/authorized_keys | tee -a $HOME/.ssh/authorized_keys && chmod 0600 $HOME/.ssh/authorized_keys && sudo rm -f /tmp/authorized_keys
USER root
ENTRYPOINT ["/init"]
CMD ["/usr/sbin/sshd","-D"]
