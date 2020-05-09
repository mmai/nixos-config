{ config, lib, pkgs, stdenv, ... }:
{
  imports = [
    ./cfg/base-desktop.nix
    ./cfg/development.nix
    ./cfg/leisure.nix
    ./cfg/atixnet.nix
    ./cfg/sync-notes.nix
  ];

  networking.hostName = "henri-desktop";

  users.extraUsers.henri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "virtualbox" ];
    shell = pkgs.zsh;
  };
  # See these files for services run as 'henri' : cfg/cli-mails.nix

  fileSystems."/mnt/diskstation/videos" = {
    device = "diskstation:/volume1/video";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };

  fileSystems."/mnt/diskstation/music" = {
    device = "diskstation:/volume1/music";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };

  fileSystems."/mnt/diskstation/data" = {
    device = "diskstation:/volume1/data";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };

  # automount remote folders
  # services.autofs = {
  #   enable = true;
  #   autoMaster =
  #     let
  #       share = pkgs.writeScript "auto-share" ''
  #   #!/bin/sh
  #   # autofs runs as root so maybe I can just become me temporarily
  #         LG=${pkgs.eject}/bin/logger
  #         cred=$(mktemp)
  #         host="$AUTOFS_HOST"
  #         share="$1"
  #         rm -f -- "$cred"
  #         touch "$cred"
  #         chmod go-rwx "$cred"
  #         answer=$(/var/setuid-wrappers/sudo -s -u "$AUTOFS_USER" pass "shares_conf/$host/$share")
  #         echo "$answer" > "$cred"
  #         echo '-fstype=cifs,credentials='"$cred"',uid=$UID   ://'"$host"'/'"$share"
  #         {sleep 3; rm -f -- "$cred"} &
  #       '';
  #       host  = pkgs.writeText "auto-host"  "*   -fstype=autofs,-DAUTOFS_HOST=& program:${share}" ;
  #       top   = "/net file:${host}" ;
  #     in top;
  #   };

  nix.trustedUsers = [ "henri" "root" ];
}
