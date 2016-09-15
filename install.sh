#!/bin/bash

DISK_NAME=atomic_disk
CLONE_DISK=atomic_disk_clone

VBoxManage import rhel-atomic-cloud-7.2.5.x86_64.vsphere.ova --vsys 0 --vmname rh_atomic --unit 11 --disk ./$DISK_NAME.vmdk

VBoxManage clonehd ./$DISK_NAME.vmdk ${CLONE_DISK}_tmp.vdi --format VDI

disk_uuid=$(VBoxManage showhdinfo ./${CLONE_DISK}_tmp.vdi | grep "^UUID:" | awk '{print $2}')

VBoxManage modifyhd ${CLONE_DISK}_tmp.vdi --resize 15360

VboxManage clonehd ${CLONE_DISK}_tmp.vdi $CLONE_DISK.vdi --variant Fixed

VBoxManage closemedium disk $disk_uuid --delete

rm -rf ${CLONE_DISK}_tmp.vdi
