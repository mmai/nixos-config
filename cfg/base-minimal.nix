{ config, lib, pkgs, ... }:
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
  #   í = <AltGr>,i
  

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    ag
    bat # better cat
    curl
    fzf
    gitFull tig
    gnumake
    htop
    iotop
    ncdu
    neovim
    nixops
    super-user-spark # dotfiles manager
    tree
    unzip
    vifm
  ];
}
