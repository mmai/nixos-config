{ config, lib, pkgs, ... }: {

  home.packages = with pkgs; [ 
    feishin # subsonic client ( ie to listen from funkwhale or navidrome services )
  ];
}

