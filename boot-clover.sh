#!/bin/bash

# See https://www.mail-archive.com/qemu-devel@nongnu.org/msg471657.html thread.
#
# The "pc-q35-2.4" machine type was changed to "pc-q35-2.9" on 06-August-2017.

##################################################################################
# NOTE: Comment out the "MY_OPTIONS" line in case you are having booting problems!
##################################################################################

MAC_HD="/media/frank/B4CEE390CEE348E6/qemu-vdisks/virtmac_hdd.img"

MY_OPTIONS="+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe"

# Remove "+xsaves" for Ryzen and Threadripper processors.

/home/frank/QEMU/bin/qemu-system-x86_64 -enable-kvm -m 8192 -cpu Penryn,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,$MY_OPTIONS \
	  -machine pc-q35-2.9 \
	  -smp 8,cores=4 \
	  -usb -device usb-kbd -device usb-tablet \
	  -device qxl-vga,id=video0,ram_size=67108864,vram_size=67108864,vgamem_mb=16 \
	  -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
	  -drive if=pflash,format=raw,readonly,file=OVMF_CODE.fd \
	  -drive if=pflash,format=raw,file=OVMF_VARS.fd \
	  -smbios type=2 \
	  -device ide-drive,bus=ide.2,drive=MacHDD \
	  -drive id=MacHDD,if=none,file=$MAC_HD \
	  -monitor stdio \
	  -netdev user,id=net0 -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27
