FROM ambakshi/devbox
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN git clone https://github.com/andytinycat/puppet-omnibus /home/dev/puppet-omnibus
WORKDIR /home/dev/puppet-omnibus
RUN bundle install
ENV GIT_PULL true
ENV OUTDIR /data
ADD ./0001-Add-hiera-eyaml-2.0.6.patch /home/dev/puppet-omnibus/
RUN git config --global user.name 'Amit Bakshi' && git config --global user.email 'ambakshi@gmail.com'
RUN git am 0001-Add-hiera-eyaml-2.0.6.patch
ADD ./build.sh /build.sh
CMD ["/build.sh"]



