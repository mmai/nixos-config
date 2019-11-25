## Low space on /boot

- `nix-collect-garbage -d`
- Remove old entries from /boot/loader/entries
- Remove old kernels from /boot/EFI/nixos/ (those not listed in the /boot/loader/entries/nixos-generation-xx.conf files)
```
nix-env -p /nix/var/nix/profiles/system --delete-generations +2
nixos-rebuild switch
```


## Unlock the 'default' keyring at startup

=> to do only if you already log in with a password

- open Seahorse (graphical keyring manager)
- change password for default keyring : enter empty password

## list installed packages

* Local : `nix-env --query`
* Local with sudo : `sudo nix-env --query`
* In configuration.nix : `nixos-option environment.systemPackages | head -2 | tail -1 | \
    sed -e 's/ /\n/g' | cut -d- -f2- | sort | uniq`

## Lenovo thinkpad 470s

Add missing resolutions with _addModeline.sh_ script
