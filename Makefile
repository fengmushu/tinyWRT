-include config.mak

TOP		:= $(shell pwd)
BB_PATH		:= $(TOP)/bb/busybox-1.35.0
LINUX_PATH	:= $(TOP)/kernel/linux-4.19.88
TOOLCHAIN_PATH	:= $(TOP)/musl-cross-make/build/local/mipsel-linux-musl/output

export CROSS_COMPILE=${TOOLCHAIN_PATH}/bin/mipsel-linux-musl-

$(BB_PATH)/.config:
	make -C $(BB_PATH) ARCH=mipsel CROSS_COMPILE=${CROSS_COMPILE} menuconfig

bzbox: $(BB_PATH)/.config
	make -C $(BB_PATH) ARCH=mipsel CROSS_COMPILE=${CROSS_COMPILE}

$(LINUX_PATH)/.config:
	make -C $(LINUX_PATH) ARCH=mips CROSS_COMPILE=$(CROSS_COMPILE) menuconfig

linux: $(LINUX_PATH)/.config
	make -C $(LINUX_PATH) ARCH=mips CROSS_COMPILE=$(CROSS_COMPILE)

config:
	make -C $(LINUX_PATH) ARCH=mips CROSS_COMPILE=$(CROSS_COMPILE) menuconfig

install:
	make -C $(BB_PATH) install

all: bzbox
	make -C $(BB_PATH)

clean:
	make -C $(BB_PATH) distclean

distclean:
	make -C $(LINUX_PATH) mrproper CROSS_COMPILE=$(CROSS_COMPILE)
