{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> {}; # XXX the "unstable" channel needs to be available : sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable && sudo nix-channel update
in
{
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  nixpkgs.config.virtualbox.enableExtensionPack = true;

  environment.systemPackages = with pkgs; [
    # Node
    nodejs
    yarn

    # PHP
    php
    php72Packages.composer
    php72Packages.psysh # 
    # php72Packages.phpcs  # CodeSniffer (detect)
    php72Packages.phpcbf # CodeSniffer (beautify)
    # Drupal coding standards installation :
    #   composer global require drupal/coder # installs phpcs as well
    #   composer global require dealerdirect/phpcodesniffer-composer-installer

    # Haskell
    cabal-install
    cabal2nix
    # haskellPackages.intero # doesn't compile (bad ghc dependency)

    # Rust
    #   more options on https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
    rustc
    cargo

    # Python & co.
    (python3.withPackages (pypkgs: [ 
      pypkgs.pygments 
    ]))

    # Python & co.
    # (unstable.python3.withPackages (pypkgs: [ 
    #   unstable.pythonPackages.pynvim # pynvim in next release 19.03 (needed for deoplete)
    #   unstable.pythonPackages.pygments 
    # ]))

    # Databases related
    mariadb # to get the client
    mysql-workbench # can export mcds ; very long to compile
    dbeaver # mysql & posgresql, can do ssh tunneling

    # Dev tools
    gitAndTools.gitflow
    gitAndTools.diff-so-fancy
    universal-ctags

    # Trying to make snx work (sitepoint network extender)
    #    archlinux : lib32-pam  lib32-libx11  lib32-libstdc++5
    #    ubuntu : libx11-6:i386 libstdc++5:i386 libpam0g:i386
    #    fedora:  libX11.i686  compat-libstdc++-33.i686 pam.i686
    # xorg.libX11 gcc5 libstdcxx5 linux-pam # => do not work, and not good for displays
  ];
}
