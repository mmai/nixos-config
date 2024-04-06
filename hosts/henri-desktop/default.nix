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
    ../common/optional/msmtp.nix # simple copie TODO
    ../common/optional/yubikey # simple copie TODO
    ../common/optional/desktop.nix # copié de cfg/base-desktop.nix  TODO : diviser en fichiers logiques
    ../common/optional/developpement.nix # copié de cfg/developpement.nix  TODO : diviser en fichiers logiques
    # ../common/optional/androidStudio.nix # copié de cfg/notRaspberry.nix
    ../common/optional/virtualbox.nix # copié de cfg/notRaspberry.nix
    ../common/optional/leisure.nix # copié de cfg/leisure.nix  TODO : diviser en fichiers logiques
    ../common/optional/sync-notes.nix # copié de cfg/sync-notes.nix  TODO : diviser en fichiers logiques
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

    nameservers = [ 
      "1.1.1.1" "1.0.0.1" # Cloudflare
      "8.8.8.8" "8.8.4.4" # Google
    ];
    # Once upon a time I tried to configure wireguard, it almost worked, it was on the 'wireguard' git tag
  };

  system.stateVersion = "23.11";
}
