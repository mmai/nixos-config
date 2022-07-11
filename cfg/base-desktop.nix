{ config, lib, pkgs, stdenv, ... }:

{
  imports = [ 
    ./base-terminal.nix 
  ];

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1; # Enable Alt+Sysrq+r key (why is it restricted by default ?) to recover from freezed X sessions
  };

  # services.keybase.enable = true; # not used anymore

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.lightdm.enable = true; # to use instead of gdm if computer freeze after login (ie on Lenovo 470s)
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.shell.app-switcher]
      current-workspace-only=true

      [org.gnome.desktop.background]
      show-desktop-icons=true
    '';
  };

  hardware.sane.enable = true; # Scanner
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.epson-escpr ]; # Generic, Epson XP-225

  # Gnome shell extensions with browsers
  nixpkgs.config.firefox.enableGnomeExtensions = true;
  services.gnome.chrome-gnome-shell.enable = true;

  networking.firewall.allowedTCPPorts = [ 8010 ]; # allow streaming to chromecast devices (vlc)

  # Enable widevine on chromium: needed by spotify & netflix
  # nixpkgs.config.chromium.enableWideVine = true; # broken on 19.03

  #FONTS
  #  nerdfonts for dev symbols in text editors
  #  noto-fonts-cjk for chinese characters
  fonts = {
    fonts = with pkgs; [
      victor-mono
      dejavu_fonts
      meslo-lg
      powerline-fonts
      nerdfonts
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
      noto-fonts-emoji
    ];

    fontconfig.defaultFonts = {
      # monospace = [ "DejaVuSansMono Nerd Font" ];
      monospace = [ "MesloLGS NF" ]; # indiquer 'family: Meslo LG S' dans alacritty.yml
    };
  };

  # Chinese input
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
  };

  # set defaults apps (especially image viewer so that it is not the last software used which become the default (I look at you Gimp))
  # for a more complete config, see https://src.fedoraproject.org/rpms/shared-mime-info/blob/rawhide/f/mimeapps.list
  environment.etc."xdg/mimeapps.list" = {
    text = ''
      [Default Applications]
      image/bmp=org.gnome.eog.desktop;
      image/gif=org.gnome.eog.desktop;
      image/jpeg=org.gnome.eog.desktop;
      image/jpg=org.gnome.eog.desktop;
      image/pjpeg=org.gnome.eog.desktop;
      image/png=org.gnome.eog.desktop;
      image/tiff=org.gnome.eog.desktop;
      image/x-bmp=org.gnome.eog.desktop;
      image/x-gray=org.gnome.eog.desktop;
      image/x-icb=org.gnome.eog.desktop;
      image/x-ico=org.gnome.eog.desktop;
      image/x-png=org.gnome.eog.desktop;
      image/x-portable-anymap=org.gnome.eog.desktop;
      image/x-portable-bitmap=org.gnome.eog.desktop;
      image/x-portable-graymap=org.gnome.eog.desktop;
      image/x-portable-pixmap=org.gnome.eog.desktop;
      image/x-xbitmap=org.gnome.eog.desktop;
      image/x-xpixmap=org.gnome.eog.desktop;
      image/x-pcx=org.gnome.eog.desktop;
      image/svg+xml=org.gnome.eog.desktop;
      image/svg+xml-compressed=org.gnome.eog.desktop;
      image/vnd.wap.wbmp=org.gnome.eog.desktop;
      image/x-icns=org.gnome.eog.desktop;
    '';
  };

  environment.gnome.excludePackages = with pkgs; [ gnome3.geary ];
  environment.systemPackages = with pkgs; [
    evolution # since 19.09 default mail client in gnome is geary
    # mailnag # don't work ? new mails on Maildir folders notification (for use with mbsync+mutt)
    # mailspring # mail client (custom package) (evolution trop buggé) # trop lourd
    gnome.gnome-tweaks
    # gnomeExtensions.dash-to-panel # broken in nixos 20.09, enable it from https://extensions.gnome.org/extension/1160/dash-to-panel/ instead
    # gnomeExtensions.timepp # pomodoro, timetracker, etc. => marked broken in nixos 20.03
    # gnomeExtensions.gtk-title-bar # not yet packaged in nixos
    gnomeExtensions.system-monitor
    nerdfonts
    xorg.xkill
    # xdotool # manipulate windows ; used to remove gnome-terminal header bar

    alacritty # faster terminal with sane default (and zoomable) ; needs > 4.0

    # appimage-run # enable execution of .AppImage packages
    appimage-run

    vlc # video viewer
    libreoffice
    firefox
    (chromium.override {
      commandLineArgs = "--load-media-router-component-extension=1"; # this allows to stream to chromecast devices from the browser
    })
    transmission-gtk # transmission
    hexchat # desktop chat client

    # Included in gnome3
    #   pdf viewer : evince (alternatives : zathura, okular)

    gnome.cheese # take photos & videos with webcam (launch with sudo ?)
    gimp
    gcolor2 # simple color selector
    inkscape

    gitg
    gparted
    keepassx2 # or keepassxc ?
    qtpass # pass gui
    meld
    gnome.seahorse # to get rid of the "gnome default keyring locked" prompt at startup
    filezilla
    # unetbootin # live linux usb creator # not supported on aarch64/rapsberrypi (requires syslinux)

    wireshark
    # missing : teamviewer, gpick

    # not used anymore
    #    kbfs keybase-gui
  ];

  # Use current path in new terminals
  # environment.interactiveShellInit = ''
  #   if [[ "$VTE_VERSION" > 3405 ]];
  #     then source "${pkgs.gnome3.vte}/etc/profile.d/vte.sh" 
  #   fi '';

}
