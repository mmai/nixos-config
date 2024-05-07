{
  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Optional Configs ####################
    common/optional/theme
    common/optional/gnome
    common/optional/hyprland
    common/optional/dunst.nix # notifications
    common/optional/rofi # menu / switcher
    common/optional/waybar # bar
    # common/optional/eww/eww-bar # bar
    # common/optional/nwg-panel.nix # bar

    common/optional/communication.nix

    #################### Host-specific Optional Configs ####################
  ];
}
