{ config, lib, pkgs, ... }:

{
  imports = [
    ./keyboard-layouts # import lafayette keyboard layout
  ];
  hardware.keyboard.zsa.enable = true; # after 21.05 enable udev rules for wally keyboard firmware flashing tool
#  services.udev.packages = [ pkgs.unstable.zsa-udev-rules ]; # before 21.05 
  # Experimental features : nixFlakes & nix-command
  nix = {
    # package = pkgs.nixFlakes;
    package = pkgs.nixUnstable;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
    "experimental-features = nix-command flakes";
  };

  # Locale settings
  time.timeZone = "Europe/Paris";
  services.openssh.enable = true;
  # services.xserver.exportConfiguration = true; # link /etc/X11/ properly, (with xkb subdirectory)

  services.xserver = {
    # layout = "lafayette42,fr"; # lafayette is in the keyboard-layouts import
    layout = "us,fr";
    xkbVariant = "intl,"; # US, intl., with dead keys
    xkbOptions = "compose:menu, grp:shifts_toggle"; # switch keyboard layout with both shift keys pressed 
  };
  console.useXkbConfig = true; # Console use same keyboard config as xserver

  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    supportedLocales = [ "fr_FR.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  # A weekly health check for the SSD drive (executes `fstrim -a -v`)
  services.fstrim.enable = true;

  networking.networkmanager.enable = true;

  # permet l'execution de programmes non patchés ( ie snx )
  # programs.nix-ld.enable = true;
  # environment.variables = {
  #   NIX_LD = pkgs.stdenv.cc.bintools.dynamicLinker;
  # };

  programs.command-not-found.enable = false; # replaced by the nix-index version
  programs.zsh = {
    enable = true;
    promptInit = ""; # disable default (use zplug system with pure prompt instead)
    interactiveShellInit = ''
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';
  };
  environment.systemPackages = 
  # let 
  #   wally-cli = (import ./packages/wally-cli.nix) { inherit lib; buildGoModule = stdenv.buildGoModule; inherit fetchFromGitHub; inherit pkg-config; inherit libusb1; };
  # in

  with pkgs; [
    # ---- nix related ----------------
    nix-index # nix packages database with command-not-found support : nix-locate 
    cachix # custom nix packages binaries cache management

    # ------------ Common tools
    curl
    wget
    nushell # a new shell..
    zoxide # z autojump like
    oh-my-posh # shell prompt configurator (compatible with zsh & nushell)
    zinit # zsh plugin manager

    # ---------- applications
    unstable.neovim luajit
    fortune # displayed in neovim landpage
    xclip # manage clipboard (needed for neovim to not freeze using xsel : https://github.com/neovim/neovim/issues/9402)
    # haskellPackages.super-user-spark # dotfiles manager / marked broken in 20.09

    # ------------- coding related
    gitFull git-filter-repo # git-filter-repo used to group '~/think' commit history by day
    subversionClient # svn is used by zinit

  ];

}
