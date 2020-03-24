{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> {}; # XXX the "unstable" channel needs to be available : sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable && sudo nix-channel update
in
{
  imports = [ 
    ./base-minimal.nix 
  ];

  services.keybase.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.lightdm.enable = true; # to use instead of gdm if computer freeze after login (ie on Lenovo 470s)
  services.xserver.desktopManager.gnome3 = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.shell.app-switcher]
      current-workspace-only=true

      [org.gnome.desktop.background]
      show-desktop-icons=true
    '';
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.epson-escpr ]; # Generic, Epson XP-225

  # Gnome shell extensions with browsers
  nixpkgs.config.firefox.enableGnomeExtensions = true;
  services.gnome3.chrome-gnome-shell.enable = true;

  # Enable widevine on chromium: needed by spotify & netflix
  # nixpkgs.config.chromium.enableWideVine = true; # broken on 19.03

  #FONTS
  #  nerdfonts for dev symbols in text editors
  #  noto-fonts-cjk for chinese characters
  fonts = {
    fonts = with pkgs; [
      victor-mono
      dejavu_fonts
      powerline-fonts
      nerdfonts
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
      noto-fonts-emoji
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

  environment.gnome3.excludePackages = with pkgs; [ gnome3.geary ];
  environment.systemPackages = with pkgs; [
    gnome3.evolution # since 19.09 default mail client in gnome is geary 
    gnome3.gnome-tweaks
    gnomeExtensions.dash-to-panel
    # gnomeExtensions.gtk-title-bar # not yet packaged in nixos
    gnomeExtensions.system-monitor
    nerdfonts
    xorg.xkill
    # xdotool # manipulate windows ; used to remove gnome-terminal header bar

    unstable.alacritty # faster terminal with sane default (and zoomable) ; needs > 4.0

    # appimage-run # enable execution of .AppImage packages
    unstable.appimage-run

    libsForQt5.vlc # video viewer
    libreoffice
    firefox
    chromium
    transmission-gtk # transmission
    hexchat # desktop chat client

    # Included in gnome3
    #   pdf viewer : evince (alternatives : zathura, okular)

    gimp
    inkscape

    gitg
    gparted
    keepassx2 # or keepassxc ?
    kbfs keybase-gui
    gnome3.meld
    gnome3.seahorse # to get rid of the "gnome default keyring locked" prompt at startup
    filezilla
    unetbootin # live linux usb creator

    # missing : rocketchat, teamviewer, gpick
  ];

  # Use current path in new terminals
  # environment.interactiveShellInit = ''
  #   if [[ "$VTE_VERSION" > 3405 ]];
  #     then source "${pkgs.gnome3.vte}/etc/profile.d/vte.sh" 
  #   fi '';

}
