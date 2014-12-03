.PHONY: run build


build:
	docker build -t ansible .

aws_env: $(HOME)/.aws/config
	grep -m1 'aws_secret_access_key' $< | awk '{printf "export %s=%s\n",toupper($$1),$$(NF)}' > $@.tmp
	grep -m1 'aws_access_key_id' $<  | awk '{printf "export %s=%s\n",toupper($$1),$$(NF)}' >> $@.tmp
	mv $@.tmp $@

run: aws_env
	boot2docker status &>/dev/null && boot2docker ssh 'sudo /usr/local/bin/ntpclient -s -h pool.ntp.org' || true
	source $^ && docker run -ti --rm \
			-e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY \
			-e SSH_AUTH_SOCK=/tmp/ssh.sock \
			-v $(SSH_AUTH_SOCK):/tmp/ssh.sock ansible bash
