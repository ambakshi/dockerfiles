FROM debian:sid
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y build-essential vim-nox git mercurial curl wget gcc g++ exuberant-ctags cscope rsync ssh openssh-server cmake python-dev ruby-dev
RUN apt-get install -y clang-3.7 clang-format-3.7 libclang-3.7-dev clang-modernize-3.7 wine64-development
RUN groupadd -g 1101 docker
RUN useradd -m -G docker -u 1100 -s /bin/bash devp
RUN curl -fsSL http://bit.ly/devbootstrap > ~/devbootstrap.sh && bash -ex ~/devbootstrap.sh
RUN sed -E 's@set rtp\+=.*$@set rtp\+=/etc/vim/bundle/Vundle.vim\ncall vundle#rc\("/etc/vim/bundle"\)\n@g' ~/.vimrc > /etc/vim/vimrc.local && rm -f ~/.vimrc
RUN rm -rf /etc/vim/bundle && mv ~/.vim/bundle /etc/vim
RUN mkdir -m 0700 -p ~devp/.vim/backup ~devp/.vim/tmp ~devp/.vim/undo ~devp/.tmp /tmp/devp /var/tmp/devp
RUN cp ~/.inputrc ~/.tmux.conf ~/.gitconfig ~/.bashrc ~devp/ && cp ~/bin/* /usr/bin || true
RUN curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-1.6.0 && chmod +x docker-1.6.0 && mv docker-1.6.0 /usr/bin/docker
RUN chown -R devp:devp /home/devp
CMD ["/bin/bash","-l"]

