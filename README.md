# bitpixie Proof of Concept

**Information:** The exploit works, but it still lacks some features and documentation.

- [x] BCD-Creator
- [x] Linux Secure Boot
- [x] Linux Exploit / VMK Scanner
- [x] Dislocker decryption
- [ ] Fully automated BCD extraction
- [ ] Complete Guided Exploit Script

## General concept of the attack
The Bitpixie bug was originally discovered by [Rairii](https://github.com/Wack0) and assigned CVE-2023-21563.
The first public demonstration of the full attack was performed by th0mas at 38c3: ["Windows BitLocker: Screwed without a Screwdriver"](https://media.ccc.de/v/38c3-windows-bitlocker-screwed-without-a-screwdriver).
Large parts of this repository are based on his work, that he also published as an article: ["Windows BitLocker -- Screwed without a Screwdriver"](https://neodyme.io/en/blog/bitlocker_screwed_without_a_screwdriver/) This article also explains potential mitigations.

## Prerequisites
In order to carry out this attack, the encrypted computer must meet certain requirements.
- It must use BitLocker without pre-boot authentication.
- It must be able to boot in PXE mode. Ideally, the PXE boot option is not disabled in the bios. On some systems, this attack may work even if PXE boot is disabled, as PXE boot can be enabled by connecting an external network card.
- The PCR Validation must not include `4`. Check with `manage-bde -protectors -get c:` This is default behaviour.

### Software requirements for the attacker machine
The following packages have to be installed on the attacker machine:
- dnsmasq
- impacket-smbserver

## How to perform the attack
The attack consists of two separate steps.
First, a modified BCD configuration file must be created specifically for the victim.
The next step is to boot the target via PXE using the modified BCD file, so that the VMK can be extracted from memory.

The TFTP server can be started with the script `bitpixie-exploit.sh`:
```
For extracting the BCD file (directly boot into shimx64.efi):
$ ./start-server.sh get-bcd <interface>

For performing trhe bitpixie attack (boot into downgraded bootmgfw.efi):
$ ./start-server.sh exploit <interface>
```

To boot into the linux system through PXE-boot, press Restart while holding down the Shift key.
This will reboot the machine into Advanced Boot Options.
There you have to click on `Use a device` and select IPv4 PXE Boot.

### Extracting the BCD file
Extracting the (unmodified) BCD file from the EFI partition is easy:
```
initrd:~# extract-bcd /dev/sda1
```
The BCD file is copied to the /root/ directory.
In the future, the BCD file will be automatically copied to the attacker machine.

### Breaking BitLocker
Start the TFTP server into exploit mode (boot into downgraded Windows boot manager).
Preform the bitpixie exploit:
```
initrd:~# run-exploit /dev/sda3
```
The BitLocker partition should now be mounted at /root/mnt.
If it did not work, reboot and try it again. Sometimes the VMK is not detected / overwritten.

Don't forget to unmount the file system after performing your changes: `umount /root/mnt`!

## How to set up a test environment
### Setting up QEMU
This exploit can be tested using QEMU.

I installed Windows 11 ([Tiny 11](https://github.com/ntdevlabs/tiny11builder)) on a newly created disk, installed all security patches and activated BitLocker.
Before creating the virtual machine, I had to edit the loader and change it to `/usr/share/OVMF/OVMF_CODE_4M.ms.fd` as shown below.

![VirtManager Settings](images/qemu-machine-settings.png)

After enabling BitLocker, change the model type of the network interface to `virtio` and set the ROM to "no" (see [this bug](https://bugs.launchpad.net/maas/+bug/1789319)).
The XML of the network interface should look lke this:
```
<interface type="network">
  <model type="virtio"/>
  <rom enabled="no"/>
  [...]
</interface>
```

### Building the initrd
All files for building the initrd can be found in the Linux-Exploit folder.
The complete alpine-initrd.xz can be built using the script `./build-initramfs.sh`.
The file is automatically transfered to the `PXE-Server/` folder.

## Mitigations that work
- Use BitLocker with Pre Boot Authentication (TPM+PIN) (Preferred way, since it also prevents a bunch of other attacks against BitLocker.)
- Apply patch [KB5025885](https://support.microsoft.com/en-us/topic/how-to-manage-the-windows-boot-manager-revocations-for-secure-boot-changes-associated-with-cve-2023-24932-41a975df-beb2-40c1-99a3-b3ff139f832d#bkmk_mitigation_guidelines) as described in the Microsoft guideline.
- Disable UEFI network stack to completely disable PXE (If none of the above is possible)
