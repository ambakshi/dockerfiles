FROM ansible/centos7-ansible
RUN mkdir -m 0700 /root/.aws
ENV HOME /root
ENV AWS_DEFAULT_REGION us-east-1
RUN pip install awscli && pip install boto
RUN yum install -y vim-enhanced rpm-libs rpm-build-libs rpm-build rpmdevtools rpm-devel python2-devel make
RUN cp /opt/ansible/ansible/plugins/inventory/ec2.py /etc/ansible/hosts && chmod +x /etc/ansible/hosts
RUN cp /opt/ansible/ansible/plugins/inventory/ec2.ini /etc/ansible
RUN make rpm
RUN yum localinstall -y rpm-build/ansible*.rpm
ADD ./aws_config /root/.aws/config
CMD bash
