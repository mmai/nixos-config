{ pkgs, ... }: {
  home.packages = with pkgs; [ nwg-panel nwg-dock-hyprland nwg-menu nwg-bar nwg-drawer nwg-launchers ];
}
