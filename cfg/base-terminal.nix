{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./base-minimal.nix
    ./cli-mails.nix # mails on terminal : mutt + mu + mbsync...
  ];

  # Pinyin characters keys : 
  #   ¯ = <shift><AltGr>$
  #   ˇ = <shift><AltGr>ù
  #   ` = <AltGr>*
  #   í = <AltGr>,i
  #  => see $(nix-build --no-out-link '<nixpkgs>' -A xorg.xkeyboardconfig)/etc/X11/xkb/symbols/fr

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
  environment.systemPackages = with pkgs; [
    # Already in base-minimal : cachix, curl, wget, neovim, xclip, gitFull

    # ---- nix related ----------------
    # nixops # nixos servers deployment => bug install python sur 21.05 ??
    nix-index # search available packages containing files (or paths) : nix-index ; nix-locate -w libstdc++.so.6

    # ------------ Classic tools alternatives
    bat # better cat
    broot # better tree
    exa # replacement for ls with sensible defaults
    fd # better find (and used by fzf in vim)
    ripgrep # Faster than grep, ag, ..

    # ------------ Common tools
    ghostscript # manipulate pdfs
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
    amfora # gemini protocol client
    tmux tmuxp # terminal multiplexer & its session manager
    # haskellPackages.super-user-spark # dotfiles manager / marked broken in 20.09
    weechat # irc,.. client
    lf # file navigator
    pistol # better file previewer (used by lf and fzf)
    # zola # static website generator

    # -------- Cli tools
    ansifilter # can remove ANSI terminal escape codes (colors, formatting..)
    fzf # selection generator

    # -------- à essayer
    hledger # accounting
    dijo # habit tracker
    # figlet # creates ascii art

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
    lazygit tig
    gitAndTools.git-annex # sync large files with git
    gitAndTools.delta # better git diff
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
