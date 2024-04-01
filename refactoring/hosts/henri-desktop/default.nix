#############################################################
#
#  Henri Desktop
#  NixOS running on MSI MS-7A71 - i5-7600K x 4 - NVIDIA GeForce GTX 1070
#
###############################################################

{ inputs, ... }: {
  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-intel

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix

    #################### Host-specific Optional Configs ####################
    # ../common/optional/services/openssh.nix # allow remote SSH access
    #
    # ../common/optional/xfce.nix # window manager
    # ../common/optional/pipewire.nix # audio
    # ../common/optional/smbclient.nix # mount the ghost mediashare
    # ../common/optional/vlc.nix # media player

    #################### Users to Create ####################
    ../common/users/henri
  ];

  # Enable some basic X server options
  services.xserver.enable = true;
  services.xserver.displayManager = {
    lightdm.enable = true;
    autoLogin.enable = true;
    autoLogin.user = "media";
  };

  networking = {
    hostName = "henri-desktop";
    enableIPv6 = false;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

  system.stateVersion = "23.11";
}
