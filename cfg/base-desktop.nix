{ config, lib, pkgs, ... }:
{
  imports = [ 
    ./base-minimal.nix 
  ];

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome3 = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.shell.app-switcher]
      current-workspace-only=true

      [org.gnome.desktop.background]
      show-desktop-icons=true
    '';
  };


  #FONTS
  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      powerline-fonts
      nerdfonts
    ];

    fontconfig.defaultFonts = {
      monospace = [ "DejaVuSansMono Nerd Font" ];
    };
  };

  # Chinese input
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
  };

  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweaks
    gnomeExtensions.dash-to-panel
    gnomeExtensions.no-title-bar
    gnomeExtensions.system-monitor
    nerdfonts

    appimage-run # enable execution of .AppImage packages

    libsForQt5.vlc # video viewer
    zathura # pdf viewer (okular, evince ?)
    libreoffice
    firefox
    chromium
    transmission-gtk # transmission

    virtualbox

    # mail : evolution included in gnome3

    gimp

    gitg
    gnome3.meld
    keepassx # keepasx2 keepassxc
    filezilla

    # missing : rocketchat, teamviewer, gpick
  ];

}
