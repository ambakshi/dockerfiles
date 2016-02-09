## 
## Build: curl -fsSL https://gist.githubusercontent.com/ambakshi/51c994271a216016edef/raw/Dockerfile | docker build -t ambakshi/devbox -
##

FROM ubuntu:trusty
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN apt-get update -y -q && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    g++ \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    libiberty-dev \
    git make \
    ruby-bundler ruby-dev vim-nox tmux tar \
    ctags python-dev bash-completion openssh-server \
    tmux wget curl

RUN wget -q https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb && dpkg -i puppetlabs-*.deb && rm -f puppetlabs-*.deb
RUN apt-get update -y -q && DEBIAN_FRONTEND=noninteractive apt-get install -y puppet-agent

## Fix up some settings to allow sudo/su without docker's terminal
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
    sed -i 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su && \
    sed -i 's@^Defaults\([ ]*\)requiretty$@#Defaults\1requiretty@g' /etc/sudoers
RUN sed -i -e 's/^GSSAPIAuthentication.*$/GSSAPIAuthentication no/g' /etc/ssh/sshd_config
RUN sed -i -e 's/^#UseDNS.*$/UseDNS no/g' /etc/ssh/sshd_config
RUN sed -i -e 's/^#X11UseLocalhost.*$/X11UseLocalhost no/g' /etc/ssh/sshd_config
RUN sed -i -e 's/^#AddressFamily.*$/AddressFamily inet/g' /etc/ssh/sshd_config

RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel && chmod 0400 /etc/sudoers.d/wheel
RUN echo 'gem: --no-rdoc --no-ri' > /etc/gemrc

RUN ln -sfn /usr/share/git-core/contrib/completion/git-prompt.sh /etc/bash_completion.d
         
## Golang 1.5.2
RUN curl -fsSL https://storage.googleapis.com/golang/go1.5.2.linux-amd64.tar.gz | tar xzf - -C /usr/local
ENV PATH=$PATH:/usr/local/go/bin

RUN gem install --source https://rubygems.org --no-rdoc --no-ri fpm bundler

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N "" && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ""
RUN mkdir -p -m 0700 /root/.ssh && touch /root/.ssh/authorized_keys && chmod 0600 /root/.ssh/authorized_keys
RUN groupadd -g 1000 vagrant && useradd -u 1000 -g vagrant -m -s /bin/bash vagrant && gpasswd --add vagrant wheel
RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.17.1.1/s6-overlay-amd64.tar.gz | tar xzf - -C /
ENV HOME=/home/vagrant
WORKDIR $HOME
USER vagrant
EXPOSE 22 80 443 8080
RUN mkdir -p -m 0700 $HOME/.ssh && curl -fsSL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub >> $HOME/.ssh/authorized_keys && chmod 0600 $HOME/.ssh/authorized_keys
RUN curl -fsSL https://gist.githubusercontent.com/ambakshi/51c994271a216016edef/raw/bootstrap.sh | /bin/bash -e
RUN echo "PS1='[\[\033[32m\]\u@\h\[\033[00m\] \[\033[36m\]\W\[\033[31m\]\$(__git_ps1)\[\033[00m\]] \$ '" >> $HOME/.bashrc
RUN echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
RUN echo 'export PATH="/usr/local/go/bin:$GOPATH/bin:$HOME/bin:$PATH"' >> $HOME/.bashrc
RUN GOPATH=$HOME vim -T dumb +GoInstallBinaries +qa!
# ONBUILD RUN ssh-keygen -q -f ~/.ssh/id_rsa -N "" && cat $HOME/.ssh/*.pub | sudo tee -a /root/.ssh/authorized_keys
# ONBUILD ADD ./authorized_keys /tmp/authorized_keys
# ONBUILD RUN cat /tmp/authorized_keys | tee -a $HOME/.ssh/authorized_keys && chmod 0600 $HOME/.ssh/authorized_keys && sudo rm -f /tmp/authorized_keys
USER root
ENTRYPOINT ["/init"]
CMD ["/usr/sbin/sshd","-D"]
