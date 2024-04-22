{ pkgs, ... }:
{
 services.gnome.gnome-keyring.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    # wrapperFeatures.gtk = true;
  };
}
