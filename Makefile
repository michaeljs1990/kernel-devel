.PHONY: install linux-config linux-build modules

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

linux-build:
	$(MAKE) -C linux

modules: linux-build
	$(MAKE) -C linux modules_install INSTALL_MOD_PATH=$(CURDIR)/modules
