.PHONY: all checkout build package docker

CLANG_VERSION?=3.7
BUILD_NUMBER?=6
LLVM=/usr/src/llvm
COMPOSE=docker-compose

export BUILD_NUMBER


docker:
	@$(COMPOSE) --help &>/dev/null || \
		{ \
			printf "Download docker-compose and try again:\n"; \
			printf "curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose\nchmod +x /usr/local/bin/docker-compose\n\n"; \
			exit 2; \
		}
	$(COMPOSE) run builder

all: checkout build package

clean:
	$(COMPOSE) run --rm builder find /code/build/ -type f -exec rm -f {} \;

checkout: $(LLVM) $(LLVM)/tools/clang $(LLVM)/projects/compiler-rt $(LLVM)/tools/clang/tools/extra $(LLVM)/tools/clang/tools/include-what-you-use

$(LLVM):
	svn co -q http://llvm.org/svn/llvm-project/llvm/trunk $@

$(LLVM)/tools/clang: $(LLVM)
	svn co -q http://llvm.org/svn/llvm-project/cfe/trunk $@

$(LLVM)/projects/compiler-rt: $(LLVM)
	svn co -q http://llvm.org/svn/llvm-project/compiler-rt/trunk $@

$(LLVM)/tools/clang/tools/extra: $(LLVM)/tools/clang
	svn co -q http://llvm.org/svn/llvm-project/clang-tools-extra/trunk $@

$(LLVM)/tools/clang/tools/include-what-you-use: $(LLVM)/tools/clang
	svn co -q http://include-what-you-use.googlecode.com/svn/trunk/ $@
	sed -i -e 's/^DIRS := *$$/DIRS := include-what-you-use/' $(LLVM)/tools/clang/tools/Makefile
	echo 'add_subdirectory(include-what-you-use)' >> $(LLVM)/tools/clang/tools/CMakeLists.txt

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
