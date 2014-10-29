#!/bin/sh

# since the cgo.a packaged in this rpm will be older than the other archives
# likely built on the ARM builder,
touch -r /usr/local/go/pkg/linux_amd64/runtime.a /usr/local/go/pkg/linux_amd64/runtime/cgo.a

/usr/sbin/update-alternatives --install /usr/bin/go \
        go /usr/local/go/bin/linux_amd64/go 90 \
        --slave /usr/bin/gofmt gofmt \
                /usr/local/go/bin/linux_amd64/gofmt \
        --slave /usr/bin/godoc godoc /usr/local/go/bin/godo
