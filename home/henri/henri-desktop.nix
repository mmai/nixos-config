{
  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Optional Configs ####################
    common/optional/hyprland
    common/optional/waybar    # bar
    common/optional/dunst.nix # notifications
    common/optional/gnome
    common/optional/theme

    #################### Host-specific Optional Configs ####################
  ];
}
