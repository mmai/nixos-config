{ config, lib, pkgs, ... }:
{
  imports = [ 
    ./base-minimal.nix 
  ];

  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
    nerdfonts

    libsForQt5.vlc # video viewer
    zathura # pdf viewer (okular, evince ?)
    libreoffice
    firefox
    chromium
    transmission-gtk # transmission

    thunderbird
    virtualbox

    gimp

    gitg
    gnome3.meld
    keepassx # keepasx2 keepassxc
    filezilla

    anki # 2.0.52
    calibre

    # missing : rocketchat, teamviewer, gpick
  ];

  services.xserver.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;

}
