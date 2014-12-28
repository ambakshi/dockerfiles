.PHONY: all build push run sshd

all: build run

build:
	docker build -t ambakshi/devbox .

push: build
	docker push ambakshi/devbox

run:
	-docker rm -f devbox 2>/dev/null
	docker run --rm -e TERM -ti -h `hostname -s`-devbox -p 2222:22 --name devbox ambakshi/devbox

sshd:
	docker run -d -e TERM -ti -h `hostname -s`-devbox -p 2222:22 --name devbox ambakshi/devbox sudo /usr/sbin/sshd -D
