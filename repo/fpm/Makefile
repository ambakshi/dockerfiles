RPM_DIST ?= el6
ITER ?= 2

FPM = fpm 
FPM_CMD = $(FPM) -s gem -t rpm -f --rpm-autoreqprov -d ruby200-ruby --gem-package-name-prefix ruby200-rubygem --rpm-dist $(RPM_DIST) --iteration $(ITER)
FPM_RPM := ruby200-rubygem-fpm-1.6.0-$(ITER).$(RPM_DIST).noarch.rpm

$(FPM_RPM): vendor
	find vendor/cache -name '*.gem' | grep -v fpm | xargs -n1 $(FPM_CMD)
	$(FPM_CMD) -d rpm-build -d rpmdevtools -d ruby200-ruby-devel -d scl-utils-build -d xz-lzma-compat -d xz -d xz-devel -d ruby200-scldevel -d rpm-devel fpm

vendor:
	bundle package

.PHONY: clean
clean:
	rm -f $(FPM_RPM) *.rpm
	rm -rf vendor
