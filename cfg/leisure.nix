{ config, lib, pkgs, ... }:
let
  # stremio = (import ./packages/stremio.nix) { inherit pkgs; };
in
  {

  environment.systemPackages = with pkgs; [
    anki # 2.0.52
    stellarium # planetarium (alternative: celestia which allows to move accross the universe)

    calibre
    yacreader # comics viewer
    # stremio # popcorntime like

    steam
    unnethack crawlTiles # some roguelike games
    leela-zero # go game engine (cmd = leelaz)=> additional steps : curl -O https://zero.sjeng.org/best-network && mv best-network ~/.local/share/leela-zero/

    obs-studio # video recording and live streaming
    picard # MusicBrainz tagger

    android-file-transfer # copy files on tablet
    
    # system related things I will only use on my personal main computer
    mydist.wally  # ergodox keyboard firmware flashing tool
    unstable.qmk  # ferris keyboard firmware flashing tool (see https://github.com/mmai/qmk_firmware/blob/master/keyboards/ferris/keymaps/mmai/readme.md)
    # unstable.wally-cli  # ergodox keyboard firmware flashing tool

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
