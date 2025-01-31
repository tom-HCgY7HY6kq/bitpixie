# PXE-Server

## About the files in this folder

### bootmgfw.efi
Windows boot manager version 10.0.22621.457.

SHA256: b5632b54120f887ec3d1f1f405ad75c71a2c066ddb34e54efa374c4f7190b2c1 (can be verified using [Winbindex](https://winbindex.m417z.com/?file=bootmgfw.efi))

### shimx64.efi
Signed shim from the [debian packages](https://packages.debian.org/buster/shim-signed)
This is version 15.7 from the buster release. It is broken on some systems

### shimx64.efi.bookworm
Signed shim from the [debian packages](https://packages.debian.org/bookworm/shim-signed)
This is version 15.8 from the bookworm release. Replace shimx64.efi with it if you get the following error during boot: "Verifying shim SBAT data failed: Security Policy Violation"

### grubx64.efi
Signed grub from the [debian packages](https://packages.debian.org/buster/grub-efi-amd64-signed)

### linux
[Signed debian kernel](https://snapshot.debian.org/package/linux-signed-amd64/5.14.6%2B2/#linux-image-5.14.0-1-amd64_5.14.6-2)

