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
  services.pcscd.enable = true; # pour Yubikey : Middleware to access a smart card using SCard API (PC/SC)
  security.pam = {
    # yubico.enable = true; # enable users listed in ~/.yubico/authorized_yubikeys to log in
    u2f.origin = "henri-deskop";
    services = { # placer les  ~/.config/Yubico/u2f_keys
        # login.u2fAuth = true;
        # sudo.u2fAuth = true;
      };
  };
  environment.systemPackages = with pkgs; [
    # Already in base-minimal : cachix, curl, wget, neovim, xclip, gitFull
    bfg-repo-cleaner # suppression des secrets d'un repo git
    helix # code editor
    ueberzugpp # display images in terminal, used by yazi
    # xpdf # Viewer for PDF files, includes pdftoppm used by telescope-media-files.nvim
    ffmpegthumbnailer # A lightweight video thumbnailer, used by yazi, telescope-media-files.nvim
    unar # archive viewer (for yazi)
    poppler # pdf viewer (for yazi)

    # ---- nix related ----------------
    # nixops # nixos servers deployment => bug install python sur 21.05 ??
    nix-index # search available packages containing files (or paths) : nix-index ; nix-locate -w libstdc++.so.6

    # ------------ Classic tools & alternatives
    bat # better cat
    tree # used by nnn
    eza # replacement for ls with sensible defaults
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
    age # crypt files (better alternative than gnupg)
    git-crypt # transparent file encryption in git
    yubikey-manager yubico-piv-tool pam_u2f

    # ---------- applications
    amfora # gemini protocol client
    tmux tmuxp # terminal multiplexer & its session manager
    # haskellPackages.super-user-spark # dotfiles manager / marked broken in 20.09
    weechat # irc,.. client
    lf # file navigator --> replaced by nnn
    (nnn.override ({ withNerdIcons = true; })) # nnn file navigator with nerd icons
    unstable.yazi # nnn replacement ?
    pistol # better file previewer (used by lf and fzf)
    sshfs # sftp
    surfraw # bookmarks & search engines client 
    sxiv # image viewer (used by nnn)
    # zola # static website generator
    unstable.offpunk # offline rss, gemini, ... reader (remplace newsboat)

    # -------- Cli tools
    ansifilter # can remove ANSI terminal escape codes (colors, formatting..)
    fzf # selection generator
    ts # task pooler (add tasks in a queue, see the task list) 

    # -------- à essayer
    hledger # accounting
    dijo # habit tracker
    # figlet # creates ascii art
    # vocage # tui spaced repetition (à la Anki) -> comment installer ?

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
    just # better make 
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
