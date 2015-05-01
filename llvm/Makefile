CLANG_VERSION?=3.7
BUILD_NUMBER?=4
LLVM=/usr/src/llvm

.PHONY: all checkout build package docker

all: checkout build package

docker:
	docker build -t llvm .
	docker inspect llvm_data &> /dev/null || docker run -d -v /code/build -v /pkg -v /usr/src --name llvm_data busybox echo DATA
	docker restart llvm &> /dev/null || docker run -ti --volumes-from llvm_data --name llvm llvm make all
	docker cp llvm:/code/llvmall_$(CLANG_VERSION)-$(BUILD_NUMBER)_amd64.deb .
	docker cp llvm:/code/llvmall-$(CLANG_VERSION)-$(BUILD_NUMBER).x86_64.rpm .

checkout: $(LLVM) $(LLVM)/tools/clang $(LLVM)/projects/compiler-rt $(LLVM)/tools/clang/tools/extra

$(LLVM):
	svn co -q http://llvm.org/svn/llvm-project/llvm/trunk $@

$(LLVM)/tools/clang: $(LLVM)
	svn co -q http://llvm.org/svn/llvm-project/cfe/trunk $@

$(LLVM)/projects/compiler-rt: $(LLVM)
	svn co -q http://llvm.org/svn/llvm-project/compiler-rt/trunk $@

$(LLVM)/tools/clang/tools/extra: $(LLVM)/tools/clang
	svn co -q http://llvm.org/svn/llvm-project/clang-tools-extra/trunk $@

build: checkout
	mkdir -p $@
	cd $@ && cmake -G 'Ninja' -DCMAKE_INSTALL_PREFIX=/opt/llvm/$(CLANG_VERSION) \
		-DCMAKE_BUILD_TYPE=Release $(LLVM) && ninja

package: build
	bundle install --path vendor/bundle --binstubs bin
	cd build && rm -rf /tmp/llvm && export DESTDIR=/tmp/llvm && ninja install
	rm -f llvmall*.deb llvmall*.rpm
	bin/fpm -s dir -t deb -n llvmall -v $(CLANG_VERSION) --iteration $(BUILD_NUMBER) -C /tmp/llvm opt
	bin/fpm -s dir -t rpm -n llvmall -v $(CLANG_VERSION) --iteration $(BUILD_NUMBER) -C /tmp/llvm opt
	test -d ../pkg && cp llvmall* ../pkg || true
