{ config, lib, pkgs, stdenv, ... }:
{
  imports = [
    ../cfg/base-desktop-light.nix
  ];

  # Pour pouvoir se connecter sur la version vm
  users.mutableUsers = true;
  users.users.henri = {
    isNormalUser = true;
    initialPassword = "henri";
    extraGroups = [ "wheel" "networkmanager" "plugdev" ];
    shell = pkgs.zsh;
  };

  users.users.guest = {
    initialPassword = "guest";
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  nix.trustedUsers = [ "henri" "root" ];

}
