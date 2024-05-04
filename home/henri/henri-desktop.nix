{
  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Optional Configs ####################
    common/optional/hyprland
    common/optional/rofi

    common/optional/waybar # bar
    # common/optional/eww/eww-bar # bar
    # common/optional/nwg-panel.nix # bar

    common/optional/dunst.nix # notifications
    common/optional/gnome
    common/optional/theme

    #################### Host-specific Optional Configs ####################
  ];
}
