{ config, lib, pkgs, ... }:
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

    # Haskell
    cabal-install
    cabal2nix
    
    # Python & co.
    (python3.withPackages (pypkgs: [ 
      # pypkgs.neovim # pynvim in next release 19.03 (needed for deoplete)
      pypkgs.pygments 
    ]))

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
