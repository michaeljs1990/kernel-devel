.PHONY: custom-debian-base cow

IMG := debian.qcow
ISO := debian-testing-i386-netinst.iso
COWLAYER := scratch.qcow

$(IMG):
	qemu-img create -f qcow2 $(IMG) 4G

$(ISO):
	wget http://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/i386/iso-cd/$(ISO)

custom-debian-base: $(IMG) $(ISO)
	qemu-system-x86_64 -hda $(IMG) -cdrom $(ISO) -boot d -m 1024 -smp 2

$(COWLAYER):
	qemu-img create -f qcow2 -o backing_file=$(IMG) $(COWLAYER)

cow: $(COWLAYER)
