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
      firewall = {
      # wireguard vpn 
        allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
      };
    };

    # Enable WireGuard
    #  prevent it to start at boot (start with `sudo systemctl start wireguard-wg0.service` or a script to set custom dns server in /etc/resolv.comf at the same time)
    systemd.services.wireguard-wg0.wantedBy = lib.mkForce [ ];
    networking.wireguard.interfaces = 
    # networking.wg-quick.interfaces = 
    let 
      vpnPublicIp = "116.203.38.71"; # activitypub.rhumbs.fr
      defaultGw = "192.168.1.1"; # On my home network... `route -n` to see it
    in 
    {
      # "wg0" is the network interface name. You can name the interface arbitrarily.
      wg0 = {
        # autostart = false; # wg-quick setting
        # dns = [ "10.0.0.1" "fdc9:281f:04d7:9ee9::1" ]; # wg-quick setting
        # Determines the IP address and subnet of the client's end of the tunnel interface.
        ips = [ "10.100.0.2/24" ]; # wireguard setting
        # address = [ "10.0.0.2/24" "fdc9:281f:04d7:9ee9::2/64" ]; # wg-quick setting
        listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

        # we need this for the `allowedIPs = [ "0.0.0.0/0" ]` to work (cf. https://discourse.nixos.org/t/route-all-traffic-through-wireguard-interface/1480/18)
        postSetup = "${pkgs.iproute}/bin/ip route add ${vpnPublicIp} via ${defaultGw}"; # wireguard setttings
        postShutdown = "${pkgs.iproute}/bin/ip route del ${vpnPublicIp} via ${defaultGw}"; # wireguard setttings
        # postUp = "${pkgs.iproute}/bin/ip route add ${vpnPublicIp} via ${defaultGw}"; # wg-quick setttings
        # preDown = "${pkgs.iproute}/bin/ip route del ${vpnPublicIp} via ${defaultGw}"; # wg-quick setttings

        privateKeyFile = "/home/henri/.wireguard-keys/private";

        peers = [
          # For a client configuration, one peer entry for the server will suffice.
          {
            # Public key of the server (not a file path).
            publicKey = "jiqwuuBBM8baFRwI59q9qxReIYZxbVFrIMxuzlTeB1o=";

            # Forward all the traffic via VPN.
            allowedIPs = [ "0.0.0.0/0" ];
            # Or forward only particular subnets
            # allowedIPs = [ "10.100.0.0/24" ];
            # allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

            # Set this to the server IP and port.
            endpoint = "${vpnPublicIp}:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

            # Send keepalives every 25 seconds. Important to keep NAT tables alive.
            persistentKeepalive = 25;
          }
        ];
      };
    };

  environment.systemPackages = with pkgs; [
    #  ----- Network
    wireguard-tools # wireguard VPN (generate keys, cf.https://nixos.wiki/wiki/WireGuard)

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
