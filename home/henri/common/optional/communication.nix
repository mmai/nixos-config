{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian
    discord
    signal-desktop
    whatsapp-for-linux
    zoom-us
  ];
}
