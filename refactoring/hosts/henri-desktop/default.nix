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
    ../common/optional/home-network.nix # access local network services (synology, etc.)
    # ../common/optional/services/openssh.nix # allow remote SSH access
    #
    # ../common/optional/xfce.nix # window manager
    # ../common/optional/pipewire.nix # audio
    # ../common/optional/smbclient.nix # mount the ghost mediashare
    # ../common/optional/vlc.nix # media player

    #################### Users to Create ####################
    ../common/users/henri
  ];

  networking = {
    hostName = "henri-desktop";
    networkmanager.enable = true;
  };

  system.stateVersion = "23.11";
}
