{ config, lib, pkgs, ... }:
  {

  environment.systemPackages = with pkgs; [
    anki # 2.0.52
    stellarium # planetarium (alternative: celestia which allows to move accross the universe)

    calibre
    yacreader # comics viewer

    steam
    leela-zero # go game engine (cmd = leelaz)=> additional steps : curl -O https://zero.sjeng.org/best-network && mv best-network ~/.local/share/leela-zero/

    obs-studio # video recording and live streaming
    unstable.picard # MusicBrainz tagger

    android-file-transfer # copy files on tablet
  ];

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
