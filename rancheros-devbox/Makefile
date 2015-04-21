.PHONY: run build clean

run: build
	docker restart devbox || docker run --privileged -v /:/mnt/host -v /var/run/docker.sock:/var/run/docker.sock -ti --name devbox --hostname devbox devbox /bin/bash -l

build:
	docker build -t devbox .

clean:
	docker rmi `docker images --filter=dangling=true -q`

