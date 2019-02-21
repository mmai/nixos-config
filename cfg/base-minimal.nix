{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> {}; # XXX the "unstable" channel needs to be available : sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable && sudo nix-channel update
in 
{

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

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    ag
    bat # better cat
    curl
    entr # run arbitrary commands when files change (example: ls *.hs | entr make build)
    expect # A tool for automating interactive applications
    fzf
    gitFull tig
    gnumake
    htop
    iotop
    ncdu
    unstable.neovim # unstable version to get correct dependencies for latests viersions of nvim plugins (ie pynvim)
    nixops
    super-user-spark # dotfiles manager
    tree
    tldr # Simplified and community-driven man pages  
    unzip
    vifm
    wget
    # optional packages that could be deported to another file
    oraclejre8
  ];

  nixpkgs.config = {
    allowUnfree = true;
    oraclejdk.accept_license = true;
    packageOverrides = pkgs: {
      jre = pkgs.oraclejre8;
    };
  };
}
