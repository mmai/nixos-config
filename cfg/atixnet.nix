{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # brlaser # imprimante Brother bureaux Bordeaux

    # Microsoft file sharing service
    # https://github.com/abraunegg/onedrive/blob/master/docs/USAGE.md
    # unstable.onedrive
    # mydist.onedrive
  ];

}
