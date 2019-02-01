{ config, lib, pkgs, ... }:
{
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
  ];
}
