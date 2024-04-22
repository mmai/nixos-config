{ pkgs, config, ... }: {
  home.packages = with pkgs; [ hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/nixos-config/home/henri/common/optional/wallpapers/wallpapers/${config.theme.wallpaper}
    wallpaper = ,~/nixos-config/home/henri/common/optional/wallpapers/wallpapers/${config.theme.wallpaper}
    ipc=true
    splash=false
  '';
}
