{ config, pkgs, ... }:

{
  imports = [ ../cachix.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.configurationLimit = 90; # the default is 100, but for some reason only 2 where showing on atixnet-desktop without explicitly setting this
}
