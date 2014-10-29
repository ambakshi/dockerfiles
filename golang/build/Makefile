golang-$(GOVERSION)-$(BUILD_NUMBER).x86_64.rpm:
	docker build -t golang-build .
	docker run --rm -v `pwd`:/target golang-build

.PHONY: clean
clean:
	rm -f golang*.rpm
