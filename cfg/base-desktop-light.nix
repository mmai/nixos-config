# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ 
    ./base-terminal.nix 
  ];

  services.xserver = {
    enable = true;
    libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
    desktopManager.xfce.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;


  environment.systemPackages = with pkgs; [
     tmux
     firefox
     # chromium
  ];

}

