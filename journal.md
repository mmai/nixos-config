## Low space on /boot

Execute `sudo sh ./scripts/freeBootSpace.sh`, which do this:
- `nix-collect-garbage -d`
- Remove old entries from /boot/loader/entries
- Remove old kernels from /boot/EFI/nixos/ (those not listed in the /boot/loader/entries/nixos-generation-xx.conf files)
```
nix-env -p /nix/var/nix/profiles/system --delete-generations +2
nixos-rebuild switch
```

## gnome labels / texts not showing

`rm -rf ~/.cache/fontconfig`

## Unlock the 'default' keyring at startup

=> to do only if you already log in with a password

- open Seahorse (graphical keyring manager)
- change password for default keyring : enter empty password

## compilation errors during nixos-rebuild

try `sudo nixos-rebuild switch --show-trace -v`

## keyboard layouts

Gnome override the default nix config : so make sure to load dotfiles/dconf-henri.ini

## list installed packages

* Local : `nix-env --query`
* Local with sudo : `sudo nix-env --query`
* In configuration.nix : `nixos-option environment.systemPackages | head -2 | tail -1 | \
    sed -e 's/ /\n/g' | cut -d- -f2- | sort | uniq`

## services logs

```
su 
journalctl vacuum--time 2d # if too many logs kept
journalctl
```

## solved problems

- do not install toybox : its ps command is not compatible with the tmux/vim navigation plugin

## Lenovo thinkpad 470s

Add missing resolutions with _scripts/addModeline.sh_ script

## NVidia

Virtualbox prevents nvidia driver to load on NixOS 21.05 -> comment lines on cfg/development.nix

Afficher erreurs Nvidia : 

```
su
journalctl | grep gdm  > logsNvida.log
```

désactivation driver "nvidia" pour machine desktop-atixnet à partir de la 21.05

## Only two last generations showing in grub

Up arrow :)

## Manually switching to a generation

```
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

sudo nix-env --switch-generation <generationNumber> -p /nix/var/nix/profiles/system
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
```

