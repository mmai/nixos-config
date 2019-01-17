{ config, lib, pkgs, ... }:
{
  imports = [ ./cfg/base-minimal.nix ];

  users.extraUsers.henri = {
    isNormalUser = true;
  };

  system.stateVersion = "18.09";
}
