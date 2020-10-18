{ config, lib, pkgs, ... }:
# let
  # unstable = import <unstable> { config.allowUnfree = true; };# XXX the "unstable" channel needs to be available : sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable && sudo nix-channel update
  # nixUserRepository = builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz";
# in
  {

    # nixpkgs.config.packageOverrides = pkgs: {
    #   nur = import nixUserRepository {
    #     inherit pkgs;
    #   };
    # };

  environment.systemPackages = with pkgs; [
    anki # 2.0.52
    stellarium # planetarium (alternative: celestia which allows to move accross the universe)

    calibre
    yacreader # comics viewer

    steam
    unstable.leela-zero # go game engine (cmd = leelaz)=> additional steps : curl -O https://zero.sjeng.org/best-network && mv best-network ~/.local/share/leela-zero/

    obs-studio # video recording and live streaming
    google-musicmanager # upload on Google Music

    android-file-transfer # copy files on tablet
  ];

  hardware.logitech.enable = true;
  # for steam
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # gateway for irc 
  # services.bitlbee = {
  #   enable = true;
  #   plugins = [
  #     pkgs.bitlbee-mastodon
  #     # all plugins: `nix-env -qaP | grep bitlbee-`
  #   ];
  # };
}
