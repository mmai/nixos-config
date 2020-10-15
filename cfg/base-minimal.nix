{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> { config.allowUnfree = true; };# XXX the "unstable" channel needs to be available : sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable && sudo nix-channel --update
  # bombadillo = (import ./packages/bombadillo.nix) { inherit pkgs; };  # gopher, gemini client
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

  console.keyMap = "fr";
  i18n = {
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

  networking.networkmanager.enable = true;

  environment.etc =
  let msmtprc = pkgs.writeText "msmtprc"
    ''
    account mailtrap
    from henri@bourcereau.fr
    host smtp.mailtrap.io
    port 2525
    user 7d0baad1433da6
    password c59e56e197f524
    tls on
    auth plain

    account default : mailtrap
    '';
  in {
    "msmtprc".source = msmtprc;
  };

  programs.gnupg.agent.enable = true; # needed for gpg / pass to work
  programs.zsh = {
    enable = true;
    promptInit = ""; # disable default (use zplug system with pure prompt instead)
  };
  environment.systemPackages = with pkgs; [
    # ---- nix related ----------------
    cachix # custom nix packages binaries cache management
    nixops # nixos servers deployment
    nix-index # search available packages containing files (or paths) : nix-index ; nix-locate -w libstdc++.so.6

    # ------------ Classic tools alternatives
    bat # better cat
    broot # better tree
    exa # replacement for ls with sensible defaults
    fd # better find (and used by fzf in vim)
    ripgrep # Faster than grep, ag, ..

    # ------------ Common tools
    curl
    ghostscript # manipulate pdfs
    wget
    zip unzip
    msmtp
    mailutils # to send email from command line : `echo 'bonjour' | mail -s "my subject" "contact@something.com"`

    # ------------ Network access
    # nfs-utils  # nfs shares
    # smbclient cifs-utils # samba shares

    # ----------- Security
    gnupg # Gnu privacy guard: used by pass/qpass, crypt emails
    pass # password manager (needs gpg)

    # ---------- applications
    tmux tmuxp # terminal multiplexer & its session manager
    unstable.neovim # need neovim > 0.4
    xclip # manage clipboard (needed for neovim to not freeze using xsel : https://github.com/neovim/neovim/issues/9402)
    super-user-spark # dotfiles manager
    weechat # irc,.. client
    lf # file navigator
    unstable.pistol # better file previewer (used by lf and fzf)
    # zola # static website generator

    # -------- Cli tools
    ansifilter # can remove ANSI terminal escape codes (colors, formatting..)
    fzf # selection generator

    # ----------- diagnostics
    lsof # show open ports, etc.
    file # Show file information. Usefull to debug 'zsh: no such file or directory' errors on binaries
    htop
    iotop
    mtr # combine ping and traceroute
    ncdu # show disk usage
    psmisc # contains utilities like fuser (display process IDs currently using files or sockets), etc.
    tcpdump # to monitor network calls (in and out)

    # -------------- Automation
    entr # run arbitrary commands when files change (example: ls *.hs | entr make build)
    expect # A tool for automating interactive applications

    # ------------- coding related
    gitFull tig
    unstable.gitAndTools.delta # better git diff
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
