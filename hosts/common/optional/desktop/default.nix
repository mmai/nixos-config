{ config, lib, pkgs, stdenv, ... }:

{
  imports = [
    ./core.nix

    # ../services/greetd.nix # display manager (launch Hyprland session)
    # ./hyprland.nix # window manager 
    
    ./gnome.nix # window manager
  ];

  # services.xserver.displayManager.lightdm.enable = true; # to use instead of gdm if computer freeze after login (ie on Lenovo 470s)

  services.xserver = {
    enable = true;
    displayManager = {
      gdm = {
        enable = true;
      };
      # sddm.enable = true;
      # defaultSession = "none+awesome";
    };
  };

  networking.firewall.allowedTCPPorts = [ 8010 ]; # allow streaming to chromecast devices (vlc)

  # Enable widevine on chromium: needed by spotify & netflix
  # nixpkgs.config.chromium.enableWideVine = true; # broken on 19.03

  environment.systemPackages = with pkgs; [

    haskellPackages.xmonad-contrib
    haskellPackages.xmonad

    # ---------- the forever quest for a good email client -----------
    #  since 19.09 default mail client in gnome is geary
    thunderbird
    # evolution # frequently loose connection, copy sent mails twice in history
    # mailnag # don't work ? new mails on Maildir folders notification (for use with mbsync+mutt)
    # mailspring # mail client (custom package) (evolution trop buggé) # trop lourd

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

    gimp
    inkscape

    gitg
    gparted
    keepassxc
    qtpass # pass gui
    meld
    filezilla
    # unetbootin # live linux usb creator # not supported on aarch64/rapsberry pi (requires syslinux)

    wireshark
    # missing : teamviewer, gpick

    # not used anymore
    #    kbfs keybase-gui

    # gnome apps installed in gnome.nix : alternatives available for other envs ?
    # gnome.cheese # take photos & videos with webcam (launch with sudo ?)
    # gcolor2 # simple color selector
    # gnome.seahorse # to get rid of the "gnome default keyring locked" prompt at startup
  ];

  # Use current path in new terminals
  # environment.interactiveShellInit = ''
  #   if [[ "$VTE_VERSION" > 3405 ]];
  #     then source "${pkgs.gnome3.vte}/etc/profile.d/vte.sh" 
  #   fi '';

}
