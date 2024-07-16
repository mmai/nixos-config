{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian
    discord
    whatsapp-for-linux
  ];
}
