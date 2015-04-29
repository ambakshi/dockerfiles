CLANG_VERSION:=3.7

.PHONY: all checkout build package docker

all: checkout build package

docker:
	docker build -t llvm .
	@docker rm -f llvm 2>/dev/null || true
	docker run -ti --name llvm llvm make -j4
	docker cp llvm:/code/llvm*.deb .
	docker cp llvm:/code/llvm*.rpm .

checkout: llvm llvm/tools/clang llvm/projects/compiler-rt

llvm:
	svn co http://llvm.org/svn/llvm-project/llvm/trunk llvm

llvm/tools/clang: llvm
	cd llvm/tools && svn co http://llvm.org/svn/llvm-project/cfe/trunk clang

llvm/projects/compiler-rt: llvm
	cd llvm/projects && svn co http://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt

build: checkout
	mkdir -p $@
	cd $@ && cmake -G 'Unix Makefiles' -DCMAKE_INSTALL_PREFIX=/opt/llvm/$(CLANG_VERSION) \
		-DCMAKE_BUILD_TYPE=Release ../llvm && make -j4

package: build
	bundle install --path vendor/bundle --binstubs bin
	cd build && rm -rf /tmp/llvm && make DESTDIR=/tmp/llvm install
	rm -f llvmall*.deb llvmall*.rpm
	bin/fpm -s dir -t deb -n llvmall -v $(CLANG_VERSION) --iteration $(BUILD_NUMBER) -C /tmp/llvm opt
	bin/fpm -s dir -t rpm -n llvmall -v $(CLANG_VERSION) --iteration $(BUILD_NUMBER) -C /tmp/llvm opt
	test -d ../data && cp llvmall* ../data || true


