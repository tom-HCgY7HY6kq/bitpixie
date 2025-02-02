#!/bin/bash

# grab BCD file
ssh -o StrictHostKeyChecking=no root@10.13.37.101 "extract-bcd /dev/sda1"
sftp -o StrictHostKeyChecking=no root@10.13.37.101:/root/BCD BCD

exit

# Read the GUID of the device
device_GUID=`sgdisk --info=3 $device | grep "unique GUID" | cut -d' ' -f 4`

echo $device_GUID
# TODO:
