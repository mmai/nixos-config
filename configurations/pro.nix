{ config, lib, pkgs, ... }:
{
  imports = [
    ../cfg/base-desktop.nix
    ../cfg/development.nix
    ../cfg/atixnet.nix
    ../cfg/sync-notes.nix
  ];

  users.extraUsers.henri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "virtualbox" "plugdev" ];
    shell = pkgs.zsh;
    # shell = pkgs.nushell;
  };

  users.extraUsers.guest = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
  # See these files for services run as 'henri' : cfg/cli-mails.nix

  nix.settings.trusted-users = [ "henri" "root" ];

}
