{ config, lib, pkgs, ... }:
let
  # stremio = (import ./packages/stremio.nix) { inherit pkgs; };
in
  {
    networking = {
      nameservers = [ 
        "1.1.1.1" "1.0.0.1" # Cloudflare
        "8.8.8.8" "8.8.4.4" # Google
      ];
      # Once upon a time I tried to configure wireguard, it almost worked, it was on the 'wireguard' git tag
    };

  environment.systemPackages = with pkgs; [
    anki # 2.0.52
    stellarium # planetarium (alternative: celestia which allows to move accross the universe)

    calibre
    yacreader # comics viewer
    zotero # bibliography manager
    # stremio # popcorntime like

    steam
    unnethack crawlTiles unstable.cataclysm-dda # some roguelike games
    leela-zero # go game engine (cmd = leelaz)=> additional steps : curl -O https://zero.sjeng.org/best-network && mv best-network ~/.local/share/leela-zero/

    obs-studio # video recording and live streaming
    python310Packages.deemix # for dlmusic.sh
    picard chromaprint # MusicBrainz tagger (picard) with fingerprint calculator (chromaprint)
    sublime-music # subsonic client ( ie to listen from funkwhale servers )

    android-file-transfer # copy files on tablet
    
    # system related things I will only use on my personal main computer
    mydist.wally  # 2.1.1 ergodox keyboard firmware flashing tool
    qmk  # ferris keyboard firmware flashing tool (see https://github.com/mmai/qmk_firmware/blob/master/keyboards/ferris/keymaps/mmai/readme.md)
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
