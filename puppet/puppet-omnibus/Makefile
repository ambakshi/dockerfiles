.PHONY: all build

IMAGE_TAG=ambakshi/puppet-omnibus
NAME=puppet-omnibus
RPM=puppet-omnibus-3.7.3-0.x86_64.rpm

all: $(RPM)

authorized_keys:
	cp ~/.ssh/id_rsa.pub $@

$(RPM): build
	docker build -t $(IMAGE_TAG) .
	-docker rm -f $(NAME) 2>/dev/null
	docker run -ti --name $(NAME) $(IMAGE_TAG)
	docker cp $(NAME):/home/dev/puppet-omnibus/pkg/$(RPM) .
	docker rm -f $(NAME)

build: authorized_keys
	docker build -t $(IMAGE_TAG) .
