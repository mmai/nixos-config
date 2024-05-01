{ pkgs, ... }: {
  # app launcher
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./themes/rounded-dark.rasi;
  };

}
