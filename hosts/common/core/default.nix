{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix # localization settings
    ./nix.nix # nix settings and garbage collection
    # ./sops.nix # TODO : secrets management (cf. https://youtu.be/6EMNHDOY-wo?si=MBWWGtCoZ62Yl7Af)
    ./zsh.nix # load a basic shell just in case we need it without home-manager

    # ./services/auto-upgrade.nix # TODO : auto-upgrade service, à activer quand la config refacto aura remplacé l'ancienne
    # ../../../cachix.nix # TODO : à activer quand la config refacto aura remplacé l'ancienne (pour avoir les bons chemins)

  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    # you can add global overlays here
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  # TODO : utiliser une confing nixos-hardware ?
  services.fstrim.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged 
    # programs here, NOT in environment.systemPackages
  ];
  # environment.variables = {
  #   NIX_LD = pkgs.stdenv.cc.bintools.dynamicLinker;
  # };

  programs.command-not-found.enable = false; # replaced by the nix-index version
  programs.gnupg.agent.enable = true; # needed for gpg / pass to work

  hardware.enableRedistributableFirmware = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.configurationLimit = 90; # the default is 100, but for some reason only 2 where showing on atixnet-desktop without explicitly setting this
  };


  environment.systemPackages = 
  # let 
  #   wally-cli = (import ./packages/wally-cli.nix) { inherit lib; buildGoModule = stdenv.buildGoModule; inherit fetchFromGitHub; inherit pkg-config; inherit libusb1; };
  # in

  with pkgs; [
  # ================ from base-minimal =====================================
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

    # ------------- coding related
    gitFull git-filter-repo # git-filter-repo used to group '~/think' commit history by day
    subversionClient # svn is used by zinit

  # ================ from base-terminal =====================================
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
    mailutils # to send email from command line : `echo 'bonjour' | mail -s "my subject" "contact@something.com"`

    # ------------ Network access
    # nfs-utils  # nfs shares
    # smbclient cifs-utils # samba shares

    # ----------- Security
    gnupg # Gnu privacy guard: used by pass/qpass, crypt emails
    pass # password manager (needs gpg)
    age # crypt files (better alternative than gnupg)
    git-crypt # transparent file encryption in git

    # ---------- applications
    # amfora # gemini protocol client
    tmux tmuxp # terminal multiplexer & its session manager
    lf # file navigator --> replaced by nnn
    pistol # better file previewer (used by lf and fzf)
    (nnn.override ({ withNerdIcons = true; })) # nnn file navigator with nerd icons
    sxiv # image viewer (used by nnn)
    unstable.yazi # nnn replacement ?
    sshfs # sftp
    surfraw # bookmarks & search engines client 
    weechat # irc,.. client
    # zola # static website generator
    # unstable.offpunk # offline rss, gemini, ... reader (remplace newsboat)

    # -------- Cli tools
    ansifilter # can remove ANSI terminal escape codes (colors, formatting..)
    fzf # selection generator
    ts # task pooler (add tasks in a queue, see the task list) 

    # -------- à essayer
    # hledger # accounting
    # dijo # habit tracker
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

}
