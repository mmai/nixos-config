{ config, lib, pkgs, ... }:
{
  imports = [ 
    ./cfg/base-desktop.nix 
  ];

  networking.hostName = "henri-desktop";

  users.extraUsers.henri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "18.09";
}
