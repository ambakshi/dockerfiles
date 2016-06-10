.PHONY: all build push run sshd

DEVBOX ?= devbox-ub14

all: build run

build:
	docker build -t devbox-ub14 -f ub14/Dockerfile .
	docker build -t devbox-el6 -f el6/Dockerfile .

push: build
	dockeer tag $(DEVBOX) ambakshi/devbox
	docker push ambakshi/devbox

run:
	-docker rm -f devbox 2>/dev/null
	docker run --rm -e TERM -ti -h `hostname -s`-devbox -p 2222:22 --name devbox $(DEVBOX)

sshd:
	docker run -d -e TERM -ti -h `hostname -s`-devbox -p 2222:22 --name devbox $(DEVBOX) sudo /usr/sbin/sshd -D

ssh:
	@chmod 0600 vagrant
	ssh -o UserKnownHostsFile=/dev/null -i vagrant -l vagrant -p 2222 localhost
