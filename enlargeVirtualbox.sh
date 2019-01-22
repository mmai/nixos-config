#!/bin/sh

MACHINE=desktop
DEPLOY=vbox-desktop

DISK_FILE=$(nixops export -d $DEPLOY | nix-shell -p jq --command "jq -r '..|.\"virtualbox.disks\"?|select(.!=null)' | jq -r .disk1.path")
nixops stop -d $DEPLOY
VBoxManage modifyhd --resize 20000 "$DISK_FILE"
nixops start -d $DEPLOY
echo "\n\n--------------------------------------------------\n In the following prompt, enter options: d n p <CR> <CR> <CR> <CR> w\n--------------------------------------------------\n\n"
nixops ssh -d $DEPLOY $MACHINE -- fdisk -u /dev/sda

nixops reboot -d $DEPLOY
nixops ssh -d $DEPLOY $MACHINE --  resize2fs /dev/sda1
nixops ssh -d $DEPLOY $MACHINE -- df -h
echo good job 👍
