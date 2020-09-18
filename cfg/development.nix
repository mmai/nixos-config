{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> {
    config = {
      allowUnfree = true; 
      oraclejdk.accept_license = true;
      packageOverrides = pkgs: {
        jre = pkgs.oraclejre8;
      };
    };
  }; # XXX the "unstable" channel needs to be available : sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable && sudo nix-channel update
  php-env-cli = (import ./packages/php/php-env-cli.nix) {inherit pkgs; };
  # lando = (import ./packages/lando.nix) { inherit lib; inherit pkgs; };#XXX nix expression not valid
  # umlDesigner = (import ./packages/umlDesigner.nix) { inherit pkgs; };
  # umlDesigner = with pkgs; (import ./packages/umlDesigner.nix) { inherit stdenv; inherit fetchurl; inherit unzip; inherit patchelf; };
in
{
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true; # XXX error on last 18.09 release => error: The option value `warnings` in `/nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/virtualisation/virtualbox-host.nix` is not a list
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # enable /etc/hosts editing (/!\ config is reset at each config rebuild)
  environment.etc.hosts.mode = "0644";

  environment.systemPackages = with pkgs; [
    # Node
    nodejs
    yarn

    # PHP
    # lando
    php-env-cli
    php72Packages.composer
    php72Packages.psysh # 
    # php72Packages.phpcs  # CodeSniffer (detect)
    php72Packages.phpcbf # CodeSniffer (beautify)
    # Drupal coding standards installation :
    #   composer global require drupal/coder # installs phpcs as well
    #   composer global require dealerdirect/phpcodesniffer-composer-installer

    # Haskell
    cabal-install
    cabal2nix
    # haskellPackages.intero # doesn't compile (bad ghc dependency)

    unstable.vlang # v language (experiment)

    # Rust
    #   more options on https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
    # rustc cargo
    rustup # then `rustup toolchain install stable; rustup default stable `
    binutils gcc gnumake openssl pkgconfig # rustup dependencies (cf. https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md)
    unstable.rust-analyzer-unwrapped # used by coc-rust in vim

    # Java / Android dev
    unstable.android-studio # launch with `unset GDK_PIXBUF_MODULE_FILE ; android-studio` (cf. https://github.com/NixOS/nixpkgs/issues/52302#issuecomment-477818365) -> done in .zsh/aliases.sh
    jetbrains.jdk
    # unstable.oraclejdk

    # dev libs
    automake autoconf zlib

    # Python & co.
    (python3.withPackages (pypkgs: [ 
      pypkgs.pygments 
    ]))

    # Python & co.
    # (unstable.python3.withPackages (pypkgs: [ 
    #   unstable.pythonPackages.pynvim # pynvim in next release 19.03 (needed for deoplete)
    # ]))

    # Databases related
    mariadb # to get the client
    sqlite
    postgresql
    # mysql-workbench # can export mcds ; very long to compile
    dbeaver # mysql & posgresql, can do ssh tunneling

    # Dev tools
    gettext # i18n
    direnv # auto set environnement when entering directories
    unstable.niv # enable to pin nix packages ( used for projects )
    docker_compose
    gitAndTools.gitflow
    gitAndTools.diff-so-fancy
    jq # command line json parser
    # umlDesigner # trop usine à gaz
    plantuml # draw UML diagrams from text
    radare2 # reverse engineering framework
    soapui # soap api testing
    universal-ctags

  ];
}
