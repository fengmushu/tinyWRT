qemu-system-aarch64 -M virt -nographic \
-m 2048 \
-smp 4 \
-cpu cortex-a53 \
-device virtio-net-pci,netdev=tap0 \
-netdev tap,id=tap0,ifname=tap0,script=no \
-device qemu-xhci,id=xhci,p2=8,p3=8 \
-device usb-host,vendorid=0x7392,productid=0x7822 \
-kernel $1 \
-append "rootfstype=ramfs init=/init" \


# -device virtio-blk-pci,drive=hd0 \
# -blockdev driver=raw,node-name=hd0,cache.direct=on,file.driver=file,file.filename=$2 \
