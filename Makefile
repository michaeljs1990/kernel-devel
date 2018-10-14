.PHONY: install linux-config linux-build modules dracut-build initramfs-build qemu-default

linux:
	@echo "Pulling down the linux kernel..."
	@echo "================================"
	@git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

linux-firmware:
	@echo "Pulling down the linux firmware..."
	@echo "=================================="
	@git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

dracut:
	@echo "Pulling down dracut..."
	@echo "======================"
	@git clone git://git.kernel.org/pub/scm/boot/dracut/dracut.git

install: linux linux-firmware dracut

linux/.config:
	$(MAKE) -C linux x86_64_defconfig kvmconfig
	@echo "==================================================="
	@echo "linux/.config has been setup tune to your liking..."

linux-config: linux/.config

linux-build: linux linux-config
	$(MAKE) -C linux

modules: linux-build
	$(MAKE) -C linux modules_install INSTALL_MOD_PATH=$(CURDIR)/modules

dracut/Makefile.inc: dracut
	cd $(CURDIR)/dracut && ./configure

dracut-build: dracut/Makefile.inc
	$(MAKE) -C dracut

initramfs-build: dracut-build modules
	$(eval IMGVER := $(shell ls -1 modules/lib/modules))
	sudo $(CURDIR)/dracut/dracut.sh -f --kmoddir $(CURDIR)/modules/lib/modules/$(IMGVER) initramfs
	sudo chown $(USER):$(USER) initramfs

qemu-default:
	qemu-system-x86_64 \
	 -drive file=$(CURDIR)/mkimgs/scratch.qcow,if=virtio \
	 -kernel $(CURDIR)/linux/arch/x86/boot/bzImage \
	 -initrd $(CURDIR)/initramfs \
	 -append "console=ttyS0 root=/dev/vda1 ro" \
	 -nographic \
	 -m 2048 \
	 -smp 4 \
	 -cpu host \
	 --enable-kvm
