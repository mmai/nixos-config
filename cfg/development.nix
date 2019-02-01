{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs
    yarn

    php

    cabal-install
    cabal2nix
    
    # Python & co.
    (python3.withPackages (pypkgs: [ 
      # pypkgs.neovim # pynvim in next release 19.03 (needed for deoplete)
      pypkgs.pygments 
    ]))

    gitAndTools.gitflow
    gitAndTools.diff-so-fancy
    universal-ctags
  ];
}
