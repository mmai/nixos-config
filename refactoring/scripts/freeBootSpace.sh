#!/bin/sh

# echo " > nix-collect-garbage -d"
# nix-collect-garbage -d

echo " > Keep only 2 lasts entries from /boot/loader/entries"
cd /boot/loader/entries && ls | head -n -2 | xargs rm --

echo " > Remove old kernels from /boot/EFI/nixos/"
TOKEEP=$(cat /boot/loader/entries/* | grep -Eow "linux-[0-9]+.[0-9]+.[0-9]+" | sort -u | sed ':a; N; $!ba; s/\n/\\|/g')  
cd /boot/EFI/nixos
# ls | grep -v $TOKEEP 
ls | grep -v $TOKEEP | xargs rm --

echo " > Delete old nixos generations"
nix-env -p /nix/var/nix/profiles/system --delete-generations +2

echo " > Rebuild system"
nixos-rebuild switch

