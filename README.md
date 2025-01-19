# bitpixie Proof of Concept

Information: This repository is still under development and does currently not yet work!

## General concept of the attack
- Discovered by Rairii (https://github.com/Wack0)
- Idea and large parts of the code from the talk "Windows BitLocker: Screwed without a Screwdriver" by th0mas (https://media.ccc.de/v/38c3-windows-bitlocker-screwed-without-a-screwdriver)

## Prerequisites
In order to carry out this attack, the encrypted computer must meet certain requirements.
- It must use Bitlocker without pre-boot authentication.
- It must be able to boot in PXE mode. Ideally, the PXE boot option is not disabled in the bios. On some systems, this attack may work even if PXE boot is disabled, as PXE boot can be enabled by connecting an external network card.

## How to perform the attack





https://github.com/Wack0/bitlocker-attacks
https://github.com/Notselwyn/CVE-2024-1086
