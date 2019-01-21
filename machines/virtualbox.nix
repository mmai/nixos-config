{ config, lib, pkgs, ... }:
{
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      autoResize = true;
    };

    boot.growPartition = true;
    boot.loader.grub.device = "/dev/sda";

    virtualisation.virtualbox.guest.enable = true;
}
