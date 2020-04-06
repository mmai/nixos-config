{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config.allowUnfree = true; };# XXX the "unstable" channel needs to be available : sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable && sudo nix-channel --update
in
{
  imports = [ 
    /etc/nixos/cachix.nix # use `cachix use mmai` to generate cachix files
    ./cli-mails.nix # mails on terminal : mutt + mu + mbsync...
  ];
  nixpkgs.config.allowUnfree = true ;

  # Locale settings
  time.timeZone = "Europe/Paris";
  services.xserver.layout = "fr";
  services.openssh.enable = true;
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
    # ---- nix related ----------------
    cachix # custom nix packages binaries cache management
    nixops # nixos servers deployment

    # ------------ Classic tools alternatives
    bat # better cat
    broot # better tree
    exa # replacement for ls with sensible defaults
    fd # better find (and used by fzf in vim)
    ripgrep # Faster than grep, ag, ..

    # ------------ Common tools
    curl
    wget
    zip unzip
    mailutils # to send email from command line : `echo 'bonjour' | mail -s "my subject" "contact@something.com"`

    # ----------- Security
    gnupg # Gnu privacy guard: used by pass/qpass, crypt emails
    pass # password manager (needs gpg)

    # ---------- applications
    tmux tmuxp # terminal multiplexer & its session manager
    unstable.neovim # need neovim > 0.4
    xclip # manage clipboard (needed for neovim to not freeze using xsel : https://github.com/neovim/neovim/issues/9402)
    super-user-spark # dotfiles manager
    weechat # irc,.. client
    vifm # file navigator
    # zola # static website generator

    # -------- Cli tools
    ansifilter # can remove ANSI terminal escape codes (colors, formatting..)
    fzf # selection generator

    # ----------- diagnostics
    file # Show file information. Usefull to debug 'zsh: no such file or directory' errors on binaries
    htop
    iotop
    ncdu
    psmisc # contains utilities like fuser (display process IDs currently using files or sockets), etc.

    # -------------- Automation
    entr # run arbitrary commands when files change (example: ls *.hs | entr make build)
    expect # A tool for automating interactive applications

    # ------------- coding related
    gitFull tig
    gnumake
    tldr # Simplified and community-driven man pages

  ];

  # nixpkgs.config = {
  #   allowUnfree = true;
  #   oraclejdk.accept_license = true;
  #   packageOverrides = pkgs: {
  #     jre = pkgs.oraclejre8;
  #   };
  # };
}
