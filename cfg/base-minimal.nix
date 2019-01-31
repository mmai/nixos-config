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

  networking.networkmanager.enable = true;

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    curl
    gitFull tig gitAndTools.gitflow
    gnumake
    htop
    iotop
    neovim
    ncdu
    super-user-spark # dotfiles manager
    tree
    universal-ctags
    unzip
    vifm
  ];
}
