{ config, lib, pkgs, ... }:

{

  # Experimental features : nixFlakes & nix-command
  nix = {
    # package = pkgs.nixFlakes;
    package = pkgs.nixUnstable;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
    "experimental-features = nix-command flakes";
  };

  # Locale settings
  time.timeZone = "Europe/Paris";
  services.xserver.layout = "fr";
  services.openssh.enable = true;

  console.keyMap = "fr";
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    supportedLocales = [ "fr_FR.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  };

  # A weekly health check for the SSD drive (executes `fstrim -a -v`)
  services.fstrim.enable = true;

  networking.networkmanager.enable = true;

  programs.zsh = {
    enable = true;
    promptInit = ""; # disable default (use zplug system with pure prompt instead)
  };
  environment.systemPackages = with pkgs; [
    # ---- nix related ----------------
    cachix # custom nix packages binaries cache management

    # ------------ Common tools
    curl
    wget

    # ---------- applications
    neovim
    xclip # manage clipboard (needed for neovim to not freeze using xsel : https://github.com/neovim/neovim/issues/9402)
    # haskellPackages.super-user-spark # dotfiles manager / marked broken in 20.09

    # ------------- coding related
    gitFull

  ];

}
