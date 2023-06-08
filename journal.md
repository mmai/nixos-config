## Low space on /boot

Execute `sudo sh ./scripts/freeBootSpace.sh`, which do this:
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
journalctl --vacuum-time 2d # if too many logs kept
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

## switch to a configuration of an other hostname


```
sudo nixos-rebuild switch --flake '/etc/nixos#henri-laptop'
```

## Erreur 'does not provide attribute ..config.system.build.toplevel'

```sh
❯ sudo nixos-rebuild switch
warning: Git tree '/home/henri/nixos-config' is dirty
building the system configuration...
warning: Git tree '/home/henri/nixos-config' is dirty
error: flake 'git+file:///home/henri/nixos-config' does not provide attribute 'packages.x86_64-linux.nixosConfigurations."henri-destktop".config.system.build.toplevel', 'legacyPackages.x86_64-linux.nixosConfigurations."henri-destktop".config.system.build.toplevel' or 'nixosConfigurations."henri-destktop".config.system.build.toplevel'

❯ sudo nixos-rebuild switch --flake .#henri-desktop
ok
```

## fonts 

What font names can be used in fonts.fontconfig.defaultFonts.monospace?

Those that fontconfig will understand. This can be queried from a font file using fc-query.

```sh
cd /nix/var/nix/profiles/system/sw/share/X11/fonts
fc-query DejaVuSans.ttf | grep '^\s\+family:' | cut -d'"' -f2
```

Note that you may need to set `fonts.fontDir.enable = true;` for that X11/fonts directory to exist. 
