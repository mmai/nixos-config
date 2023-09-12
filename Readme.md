# My NixOS configuration

## Installation

### Cachix

If you don't want to use [cachix](https://cachix.org/), you can just comment the `imports = [ /etc/nixos/cachix.nix ];` line in `cfg/base-minimal.nix` file.

Otherwise you must create an account on cachix, install and initiate cachix (see
getting started on https://app.cachix.org/)

```sh
nix-env -iA cachix -f https://cachix.org/api/v1/install # installs cachix client
cachix use yourCachixName
```

### Main install

```
sudo ln -s $(pwd) /etc/nixos
sudo nixos-rebuild switch --flake .#$(hostname)
```

## Dotfiles

To fully replicate my desktop configuration, you can even install my dotfiles :

- fork the https://github.com/mmai/dotfiles repository
- follow the _Replication_ instrutions on https://github.com/mmai/dotfiles/tree/master/.dotfiles 

## Usage

Cache packages having long compilation times :

```
cachix push mmai /nix/store/90drn4s9imafkz56nwrplhqgd9bjdw0f-virtualbox-6.0.14
```



