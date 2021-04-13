{ config, lib, pkgs, stdenv, ... }:
{
  imports = [
    ../cfg/base-desktop-light.nix
  ];

  networking.hostName = "henri-netbook";

  users.extraUsers.henri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "plugdev" ];
    shell = pkgs.zsh;
  };

  users.extraUsers.guest = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  nix.trustedUsers = [ "henri" "root" ];

}
