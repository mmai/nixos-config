#!/bin/sh

# echo " > nix-collect-garbage -d"
# nix-collect-garbage -d

echo " > Keep only 2 lasts entries from /boot/loader/entries"
cd /boot/loader/entries && ls | head -n -2 | sudo xargs rm --

echo " > Remove old kernels from /boot/EFI/nixos/"
TOKEEP=$(cat /boot/loader/entries/* | grep -Eow "linux-[0-9]+.[0-9]+.[0-9]+" | sort -u | sed ':a; N; $!ba; s/\n/\\|/g')
cd /boot/EFI/nixos || exit
ls | grep -v $TOKEEP | xargs sudo rm --

echo " > Delete old nixos generations"
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2

echo " > Rebuild system"
sudo nixos-rebuild switch

# en dernier recours :
# sudo mv /boot/EFI/Microsoft ~/backup_boot_Microsoft/
# sudo nixos-rebuild switch
# just free-boot-space
# sudo mv ~/backup_boot_Microsoft/ /boot/EFI/Microsoft
