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

  ];

}
