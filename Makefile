-include config.mak

TOP		:= $(shell pwd)
BB_PATH		:= $(TOP)/bb/busybox-1.35.0
LINUX_PATH	:= $(TOP)/kernel/linux-4.19.88
TOOLCHAIN_PATH	:= $(TOP)/musl-cross-make/build/local/mipsel-linux-musl/output

export CROSS_COMPILE=${TOOLCHAIN_PATH}/bin/mipsel-linux-musl-

# config
$(BB_PATH)/.config:
	cp configs/bb.config $(BB_PATH)/.config
	make -C $(BB_PATH) ARCH=mipsel CROSS_COMPILE=${CROSS_COMPILE} menuconfig

$(LINUX_PATH)/.config:
	make -C $(LINUX_PATH) ARCH=mips CROSS_COMPILE=$(CROSS_COMPILE) menuconfig

bzbox: $(BB_PATH)/.config
	make -C $(BB_PATH) ARCH=mipsel CROSS_COMPILE=${CROSS_COMPILE} -j4

linux: $(LINUX_PATH)/.config
	make -C $(LINUX_PATH) ARCH=mips CROSS_COMPILE=$(CROSS_COMPILE) -j4 uImage.lzo

bb_config:
	make -C $(BB_PATH) ARCH=mipsel CROSS_COMPILE=${CROSS_COMPILE} menuconfig

linux_config:
	make -C $(LINUX_PATH) ARCH=mips CROSS_COMPILE=$(CROSS_COMPILE) menuconfig

save_conf:
	cp $(BB_PATH)/.config configs/bb_$(shell date +%Y-%d-%H-%S).config
	cp $(LINUX_PATH)/.config configs/linux_$(shell date +%Y-%d-%H-%S).config

# build
all: bzbox
	make -C $(BB_PATH)

install:
	make -C $(BB_PATH) install

clean:
	make -C $(BB_PATH) distclean

distclean:
	make -C $(LINUX_PATH) mrproper CROSS_COMPILE=$(CROSS_COMPILE)
