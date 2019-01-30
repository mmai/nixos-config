{ config, lib, pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix 
    ./cfg/base-minimal.nix 
  ];

  networking.hostName = "henri-desktop";

  users.extraUsers.henri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  system.stateVersion = "18.09";
}
