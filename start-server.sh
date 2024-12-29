#!/bin/bash

# TODO: Inferface abfragen
$interface="eth0"

sudo dnsmasq --no-daemon --interface=$interface --dhcp-range=10.13.37.100, 10.13.37.101, 255.255.255.0, 1h --dhcp-boot=bootmgfw.efi --enable-tftp --tftp-root=PXE-Server --log-dhcp
