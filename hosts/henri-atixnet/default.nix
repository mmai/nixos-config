#############################################################
#
#  Henri Atixnet Desktop
#
###############################################################

{ inputs, ... }: {
  imports = [
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-intel

    #################### Required Configs ####################
    ../common/core
    ./hardware-configuration.nix # detected hardware-configuration

    #################### Host-specific Optional Configs ####################
    ../common/optional/msmtp.nix # simple copie extraite de base_terminal.nix TODO
    ../common/optional/destkop.nix # copié de cfg/base-desktop.nix  TODO : diviser en fichiers logiques
    ../common/optional/developpement.nix # copié de cfg/developpement.nix  TODO : diviser en fichiers logiques
    # ../common/optional/androidStudio.nix # copié de cfg/notRaspberry.nix
    ../common/optional/virtualbox.nix # copié de cfg/notRaspberry.nix
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
    hostName = "henri-atixnet";
    networkmanager.enable = true;
  };

  system.stateVersion = "23.11";
}
