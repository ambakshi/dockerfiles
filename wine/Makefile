.PHONY: all image run ssh

IMAGE_OWNER = $(USER)
SERVER ?= $(shell echo $(DOCKER_HOST) | grep -Eow '([0-9\.]+)' | head -1)
all: run ssh

insecure:
	ssh-keygen -N "" -f $@

image:
	docker build -t $(IMAGE_OWNER)/wine .

run: insecure image
	-docker stop wine 2>/dev/null
	-docker rm wine 2>/dev/null
	docker run -ti --hostname `hostname -s`-wine.local --name wine -d -p 2222:22 $(IMAGE_OWNER)/wine
	sleep 2

ssh:
	ssh -Y -X -i insecure -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -oPort=2222 root@$(SERVER)

