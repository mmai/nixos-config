{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Microsoft teams instant messaging
    unstable.teams

    # Microsoft file sharing service
    # https://github.com/abraunegg/onedrive/blob/master/docs/USAGE.md
    # unstable.onedrive
    mydist.onedrive
  ];

}
