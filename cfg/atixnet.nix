{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    unstable.teams # Microsoft teams instant messaging
  ];

}
