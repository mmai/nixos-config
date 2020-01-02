{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config.allowUnfree = true; };# XXX the "unstable" channel needs to be available : sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable && sudo nix-channel update
in 
{
  nixpkgs.config.allowUnfree = true ;

  # Locale settings
  time.timeZone = "Europe/Paris";
  services.xserver.layout = "fr";
  i18n = {
    consoleKeyMap = "fr";
    defaultLocale = "fr_FR.UTF-8";
    supportedLocales = [ "fr_FR.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };
  # Pinyin characters keys : 
  #   ¯ = <shift><AltGr>$
  #   ˇ = <shift><AltGr>ù
  #   ` = <AltGr>*
  #   í = <AltGr>,i
  #  => see $(nix-build --no-out-link '<nixpkgs>' -A xorg.xkeyboardconfig)/etc/X11/xkb/symbols/fr

  # A weekly health check for the SSD drive (executes `fstrim -a -v`)
  services.fstrim.enable = true;

  networking.defaultMailServer = {
    directDelivery = true;
    useSTARTTLS = true;
    hostName = "smtp.mailtrap.io:2525";
    authUser = "7d0baad1433da6";
    authPass = "c59e56e197f524";
    # authPassFile = "/home/henri/ssmtp-authpass-mailtrap";
  };

  networking.networkmanager.enable = true;

  programs.zsh = {
    enable = true;
    promptInit = ""; # disable default (use zplug system with pure prompt instead)
  };
  environment.systemPackages = with pkgs; [
    ag
    bat # better cat
    curl
    entr # run arbitrary commands when files change (example: ls *.hs | entr make build)
    exa # replacement for ls with sensible defaults
    expect # A tool for automating interactive applications
    fd # better find (and used by fzf in vim)
    file # Show file information. Usefull to debug 'zsh: no such file or directory' errors on binaries
    fzf
    gitFull tig
    gnumake
    htop
    iotop
    ncdu
    unstable.neovim # unstable version to get correct dependencies for latests versions of nvim plugins (ie pynvim)
    nixops
    mailutils
    super-user-spark # dotfiles manager
    tree
    tldr # Simplified and community-driven man pages  
    taskwarrior tasksh timewarrior
    unzip
    vifm
    weechat # irc,.. client
    wget
    zip
    # zola # static website generator
    # optional packages that could be deported to another file
    # oraclejre8
  ];

  # nixpkgs.config = {
  #   allowUnfree = true;
  #   oraclejdk.accept_license = true;
  #   packageOverrides = pkgs: {
  #     jre = pkgs.oraclejre8;
  #   };
  # };
}
