#!/bin/bash

if [[ "$1" = "" ]]
then
  echo "Usage: ./start-server.sh <interface>"
  exit
fi

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
interface=$1

sudo ip a add 10.13.37.100/24 dev $interface

sudo dnsmasq --no-daemon --interface=$interface --dhcp-range=10.13.37.100,10.13.37.101,255.255.255.0,1h --dhcp-boot=bootmgfw.efi --enable-tftp --tftp-root=$SCRIPTPATH/PXE-Server --log-dhcp
