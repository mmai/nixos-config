## Low space on /boot

- `nixos-garbage -d`
- Remove old entries from /boot/entries
- Remove old kernels from /boot/EFI/nixos/ (those not listed in the /boot/entries/nixos-generation-xx.conf files)
- `nixos-rebuild switch` => should 


## Lenovo thinkpad 470s

Add missing resolutions with _addModeline.sh_ script
