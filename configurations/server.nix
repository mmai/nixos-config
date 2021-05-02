{ config, lib, pkgs, stdenv, ... }:
{
  imports = [
    ../cfg/base-minimal.nix
  ];

  networking.hostName = "nettop";

  users.extraUsers.henri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "plugdev" ];
    shell = pkgs.zsh;
  };

  nix.trustedUsers = [ "henri" "root" ];

}
