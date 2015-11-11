
IMAGE_OWNER = $(USER)
all: run

id_rsa:
	ssh-keygen -f $@

image:
	docker build -t $(IMAGE_OWNER)/wine .

run: id_rsa run

