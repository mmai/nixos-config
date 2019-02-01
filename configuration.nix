{ config, lib, pkgs, ... }:
{
  imports = [ 
    ./cfg/base-desktop.nix 
    ./cfg/development.nix 
  ];

  networking.hostName = "henri-desktop";

  users.extraUsers.henri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "18.09";
}
