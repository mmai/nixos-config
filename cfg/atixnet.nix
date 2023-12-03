{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Microsoft file sharing service
    # https://github.com/abraunegg/onedrive/blob/master/docs/USAGE.md
    # unstable.onedrive
    # mydist.onedrive
  ];

}
