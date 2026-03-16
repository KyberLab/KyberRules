#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# nbd_dev_init
# $(1) nbd device file path
define nbd_dev_init
	$(IQ)-sudo modprobe nbd max_part=8 > /dev/null 2>&1; exit 0
	$(IQ)-sudo mknod $(1) b 43 0 > /dev/null 2>&1; exit 0
endef


# nbd_dev_connect
# $(1) nbd device file path
# $(2) qemu image file path
define nbd_dev_connect 
	$(IQ)sudo bash -c "export PATH=$${PATH}; qemu-nbd --connect=$(1) $(2)"
endef


# nbd_dev_disconnect
# $(1) nbd device file path
define nbd_dev_disconnect
	$(IQ)-sudo bash -c "export PATH=$${PATH}; qemu-nbd --disconnect $(1)"
endef


# nbd_dev_part
# $(1) nbd device file path
# $(2) disk partition table
define nbd_dev_part
	$(IQ)sudo sgdisk $(1) --zap-all --clear --mbrtogpt
	$(IQ)sudo sgdisk $(1) $(2)
	$(IQ)sudo sgdisk $(1) -p
endef


# nbd_dev_part_mknode
# $(1) nbd device file name
define nbd_dev_part_mknode
	$(IQ)-lsblk | tr -d "├─" | awk '$$1~"$(1)p" {print "sudo mknod /dev/" $$1 " b " $$2}' | tr : " " | xargs -i bash -c {}
endef


# nbd_dev_part_rmnode
# $(1) nbd device file name
define nbd_dev_part_rmnode
	$(IQ)-lsblk | tr -d "├─" | awk '$$1~"$(1)p" {print "sudo rm -fv /dev/" $$1}' | tr : " " | xargs -i bash -c {}
endef


# nbd_dev_format
# $(1) nbd device file path
# $(2) nbd device file name
# $(3) partition index
# $(4) partition type
# $(5) partition options
define nbd_dev_format
	$(IQ)sudo mkfs.$(4) $(5) $(1)p$(3)
endef


# nbd_dev_part_print
# $(1) nbd device file path
# $(2) nbd device file name
define nbd_dev_part_print
	$(IQ)sudo sgdisk $(1) -p
endef

