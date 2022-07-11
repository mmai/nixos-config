{ config, lib, pkgs, ... }:
let
  # php-env-cli = (import ./packages/php/php-env-cli.nix) {inherit pkgs; };
  # lando = (import ./packages/lando.nix) { inherit lib; inherit pkgs; };#XXX nix expression not valid
  # umlDesigner = (import ./packages/umlDesigner.nix) { inherit pkgs; };
  # umlDesigner = with pkgs; (import ./packages/umlDesigner.nix) { inherit stdenv; inherit fetchurl; inherit unzip; inherit patchelf; };
in
{
  # enable /etc/hosts editing (/!\ config is reset at each config rebuild)
  environment.etc.hosts.mode = "0644";

  environment.systemPackages = 
  let
    php' = pkgs.php.buildEnv {
      extensions = { enabled, all }: enabled ++ [ all.xsl all.xdebug ]; # xsl needed by symfony
      extraConfig = ''
        memory_limit = 2G
        post_max_size=101M
        upload_max_filesize=100M
        xdebug.mode=debug
      '';
    };
  in with pkgs; [
    qemu # virtualisation

    # Node
    nodePackages.node2nix
    nodejs
    yarn

    # PHP
    # lando
    # php-env-cli # for msgpack
    php'
    php'.packages.composer
    php'.packages.psysh # 
    php'.packages.phpcbf # CodeSniffer (beautify)
    # Drupal coding standards installation :
    #   composer global require drupal/coder # installs phpcs as well
    #   composer global require dealerdirect/phpcodesniffer-composer-installer

    # Haskell
    cabal-install
    cabal2nix

    # Rust
    #   more options on https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md
    # rustc cargo
    rustup # then `rustup toolchain install stable; rustup default stable `
    binutils gcc gnumake openssl pkgconfig # rustup dependencies (cf. https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md)
    rust-analyzer-unwrapped # used by coc-rust in vim

    # dev libs
    automake autoconf zlib

    # Python & co.
    (python3.withPackages (pypkgs: [ 
      pypkgs.pygments 
      pypkgs.pylint 
      pypkgs.pip 
      pypkgs.pynvim # neovim integration 
    ]))

    # Databases related
    mariadb # to get the client
    sqlite
    postgresql
    # mysql-workbench # can export mcds ; very long to compile
    dbeaver # mysql & posgresql, can do ssh tunneling

    # Dev tools
    gettext # i18n
    direnv # auto set environnement when entering directories
    docker-compose
    gitAndTools.gitflow
    gitAndTools.diff-so-fancy
    jq # command line json parser
    pup # Streaming HTML processor/selector (aka jq for HTML)
    # umlDesigner # trop usine à gaz
    plantuml # draw UML diagrams from text
    radare2 # reverse engineering framework
    soapui # soap api testing
    universal-ctags

  ];

  # pour atixnet mydev
  # environment.unixODBCDrivers = with pkgs; [ unixODBCDrivers.msodbcsql17 ];
}
