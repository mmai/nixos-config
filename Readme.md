# My NixOS configuration

Usage :

```
	sudo ln -s $(pwd)/configuration.nix /etc/nixos/myconfig.nix
```

Then add _./myconfig.nix_ in _/etc/nixos/configuration.nix_ imports and do a `nixos-rebuild switch`

To fully replicate my desktop configuration, you can even install my dotfiles :

```
git clone https://github.com/mmai/dotfiles.git
cd dotfiles
make install
```
