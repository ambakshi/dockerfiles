## 
## Build: curl -fsSL https://gist.githubusercontent.com/ambakshi/51c994271a216016edef/raw/Dockerfile | docker build -t ambakshi/devbox -
##

FROM centos:centos6
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

## RUN yum update -y
## RUN yum groupinstall -y 'Development tools'

RUN yum install -y epel-release man which
RUN rpm -Uvh http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-13.ius.centos6.noarch.rpm
RUN yum install -y tar gzip ruby ruby-devel rubygems python python-devel hg ctags-etags \
    sudo bash-completion curl gcc gcc-c++ make openssh openssh-server openssh-clients git2u
RUN yum install -y rpmdevtools rpm-build rpm-libs

RUN yum localinstall -y \
             http://yum.baksh.io/el/6/x86_64/vim-7.4-1.x86_64.rpm \
             http://yum.baksh.io/el/6/x86_64/tmux-1.9a-5.x86_64.rpm \
             http://yum.baksh.io/el/6/x86_64/puppet-omnibus-3.7.3-0.x86_64.rpm
### This step can be skipped since git went to v2 we install it directly
## RUN yum -y install yum-plugin-replace git
## RUN yum replace --enablerepo='ius*' -y git --replace-with git2u
## RUN yum install -y git2u
RUN yum clean all

## Fix up some settings to allow sudo/su without docker's terminal
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
RUN sed -i 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su
RUN sed -i 's@^Defaults\([ ]*\)requiretty$@#Defaults\1requiretty@g' /etc/sudoers
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel && chmod 0400 /etc/sudoers.d/wheel
RUN echo 'gem: --no-rdoc --no-ri' > /etc/gemrc
RUN ln -sfn /usr/share/git-core/contrib/completion/git-prompt.sh /etc/bash_completion.d

## Golang 1.4
RUN curl -fsSL https://storage.googleapis.com/golang/go1.4.linux-amd64.tar.gz | tar xzf - -C /usr/local

RUN gem install fpm
RUN gem install bundler

RUN mkdir -p -m 0700 /root/.ssh && touch /root/.ssh/authorized_keys && chmod 0600 /root/.ssh/authorized_keys
RUN groupadd -g 1000 dev && useradd -u 1000 -g dev -m -s /bin/bash dev && gpasswd --add dev wheel
WORKDIR /home/dev
ENV HOME /home/dev
USER dev
EXPOSE 22 80 443 8080
RUN curl -fsSL https://gist.githubusercontent.com/ambakshi/51c994271a216016edef/raw/bootstrap.sh | /bin/bash -e
RUN echo "PS1='[\[\033[32m\]\u@\h\[\033[00m\] \[\033[36m\]\W\[\033[31m\]\$(__git_ps1)\[\033[00m\]] \$ '" >> /home/dev/.bashrc
RUN echo 'export GOPATH=$HOME' >> /home/dev/.bashrc
RUN echo 'export PATH="$HOME/bin:$PATH:/usr/local/go/bin"' >> /home/dev/.bashrc
ENV PATH $HOME/bin:$PATH:/usr/local/go/bin
RUN GOPATH=/home/dev vim -T dumb +GoInstallBinaries +qa!
ONBUILD RUN ssh-keygen -q -f ~/.ssh/id_rsa -N "" && cat /home/dev/.ssh/*.pub | sudo tee -a /root/.ssh/authorized_keys
ONBUILD ADD ./authorized_keys /tmp/authorized_keys
ONBUILD RUN cat /tmp/authorized_keys | tee -a /home/dev/.ssh/authorized_keys && chmod 0600 /home/dev/.ssh/authorized_keys && sudo rm -f /tmp/authorized_keys
CMD ["/bin/bash","--login","-i"]
