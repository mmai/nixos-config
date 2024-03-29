{ config, lib, pkgs, stdenv, ... }:

{
  imports = [ 
    ./base-terminal.nix 
  ];

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1; # Enable Alt+Sysrq+r key (why is it restricted by default ?) to recover from freezed X sessions
  };

  # services.xserver.displayManager.lightdm.enable = true; # to use instead of gdm if computer freeze after login (ie on Lenovo 470s)

services.xserver = {
    enable = true;

    displayManager = {
      gdm = {
        enable = true;
        # wayland = false; # disable wayland in order to allow microsoft teams to share desktop
      };
      # sddm.enable = true;
      # defaultSession = "none+awesome";
    };

    windowManager = {
      xmonad.enable = true;
      awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks # is the package manager for Lua modules
          luadbi-mysql # Database abstraction layer
        ];
      };
    };

    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
      [org.gnome.shell.app-switcher]
      current-workspace-only=true

      [org.gnome.desktop.background]
      show-desktop-icons=true
      '';
    };
  };

  # Gnome shell extensions with browsers
  services.gnome.gnome-browser-connector.enable = true;
  nixpkgs.config.firefox.enableGnomeExtensions = true; # deprecated, replaced by following directive
  programs.firefox.nativeMessagingHosts.packages = [
    pkgs.gnome-browser-connector
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.sane.enable = true; # Scanner
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint pkgs.epson-escpr ]; # Generic, Epson XP-225

  networking.firewall.allowedTCPPorts = [ 8010 ]; # allow streaming to chromecast devices (vlc)

  # Enable widevine on chromium: needed by spotify & netflix
  # nixpkgs.config.chromium.enableWideVine = true; # broken on 19.03

  #FONTS
  #  nerdfonts for dev symbols in text editors
  #  noto-fonts-cjk for chinese characters
  fonts = {
    # permet de lister les fonts dans /nix/var/nix/profiles/system/sw/share/X11/fonts : 
    # cd /nix/var/nix/profiles/system/sw/share/X11/fonts
    # fc-query MesloLGSNerdFontMono-Regular.ttf | grep 'family:'
    fontDir.enable = true;

    packages = with pkgs; [
      victor-mono
      dejavu_fonts
      meslo-lgs-nf
      fantasque-sans-mono # `a tester
      powerline-fonts
      nerdfonts
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk
      noto-fonts-emoji
    ];

    fontconfig.defaultFonts = {
      # monospace = [ "DejaVuSansMono Nerd Font" ];
      monospace = [ "MesloLGS Nerd Font Mono" ]; # font recommended by powerlevel10k zsh prompt. 
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

    haskellPackages.xmonad-contrib
    haskellPackages.xmonad

    # ---------- the forever quest for a good email client -----------
    #  since 19.09 default mail client in gnome is geary
    thunderbird
    # evolution # frequently loose connection, copy sent mails twice in history
    # mailnag # don't work ? new mails on Maildir folders notification (for use with mbsync+mutt)
    # mailspring # mail client (custom package) (evolution trop buggé) # trop lourd

    gnome.gnome-tweaks
    # gnomeExtensions.dash-to-panel # broken in nixos 20.09, enable it from https://extensions.gnome.org/extension/1160/dash-to-panel/ instead
    # gnomeExtensions.timepp # pomodoro, timetracker, etc. => marked broken in nixos 20.03
    # gnomeExtensions.gtk-title-bar # not yet packaged in nixos
    gnomeExtensions.system-monitor
    nerdfonts
    xorg.xkill
    xdotool # manipulate gui windows from command line 
    xdragon # drag & drop from command line

    alacritty # faster terminal with sane default (and zoomable) ; needs > 4.0

    # appimage-run # enable execution of .AppImage packages
    appimage-run

    vlc # video viewer
    libreoffice
    firefox
    (chromium.override {
      commandLineArgs = "--load-media-router-component-extension=1"; # this allows to stream to chromecast devices from the browser
    })
    tor-browser-bundle-bin # TOR browser
    transmission-gtk # transmission
    hexchat # desktop chat client
    element-desktop # matrix client

    # Included in gnome3
    #   pdf viewer : evince (alternatives : zathura, okular)
    xournalpp # manipulation de pdf : permet d'ajouter une signature png

    gnome.cheese # take photos & videos with webcam (launch with sudo ?)
    gimp
    gcolor2 # simple color selector
    inkscape

    gitg
    gparted
    keepassxc
    qtpass # pass gui
    meld
    gnome.seahorse # to get rid of the "gnome default keyring locked" prompt at startup
    filezilla
    # unetbootin # live linux usb creator # not supported on aarch64/rapsberry pi (requires syslinux)

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
