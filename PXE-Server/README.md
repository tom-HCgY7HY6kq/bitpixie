# PXE-Server

## About the files in this folder

### bootmgfw.efi
Windows boot manager version 10.0.22621.457, see [Winbindex](https://winbindex.m417z.com/?file=bootmgfw.efi).

`SHA256: b5632b54120f887ec3d1f1f405ad75c71a2c066ddb34e54efa374c4f7190b2c1`

### shimx64.efi
Signed shim from the [debian packages](https://packages.debian.org/bookworm/shim-signed)
This is version 15.8 shimx64.efi from the bookworm release.

### grubx64.efi
Signed grub from the [debian packages](https://packages.debian.org/buster/grub-efi-amd64-signed)

### linux
Signed debian kernel version 5.14 taken from the [debian packages](https://snapshot.debian.org/package/linux-signed-amd64/5.14.6%2B2/#linux-image-5.14.0-1-amd64_5.14.6-2).
