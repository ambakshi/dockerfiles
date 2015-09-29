### Qemu build container

The results will be in /opt/qemu-2.4.0.1

    $ docker run -v /opt:/opt -it --rm ambakshi/qemu-build:latest 

### Sample run of Win2012R2

Download the Win2012R2 ISO, then create a 120G qcow2 image and point qemu at it.

    $ /opt/qemu-2.4.0.1/bin/qemu-img create -f qcow2 win2012r2.qcow2 120G
    $ /opt/qemu-2.4.0.1/bin/qemu-system-x86_64  -boot d -m 2048 -cpu host -smp 2 -enable-kvm -sdl -hda win2012r2.qcow2 -cdrom 9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.ISO



