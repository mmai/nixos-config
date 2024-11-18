{ config, lib, pkgs, ... }:
{
  virtualisation.virtualbox.host.enable = true;
  #  Host extensions cause frequent recompilation.
  #  (and they seem to only be needed to share usb ports)
  # virtualisation.virtualbox.host.enableExtensionPack = true;
}
