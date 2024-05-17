{
  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Optional Configs ####################
    common/optional/hyprland
    common/optional/rofi

    common/optional/waybar # bar

    common/optional/dunst.nix # notifications
    common/optional/gnome
    common/optional/theme

    common/optional/communication.nix
    common/optional/media-players.nix

    #################### Host-specific Optional Configs ####################
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1, 2560x1440@75, 0x0, 1" # Acer incurvé Atixnet
        ", preferred, 0x0, 1" # réglage par défaut moniteurs inconnus
        "eDP-1, 1440x900@60, auto-right, 1" # moniteur intégré
    ]; 
    # workspace = let 
    #    monitor1 = "eDP-1";
    #  monitor2 = "HDMI-A-1";
    #  in 
    #    [
    #    "1, monitor:${monitor1}"
    #      "2, monitor:${monitor1}"
    #      "3, monitor:${monitor1}"
    #      "4, monitor:${monitor1}"
    #      "5, monitor:${monitor2}"
    #      "6, monitor:${monitor2}"
    #      "7, monitor:${monitor2}"
    #      "8, monitor:${monitor2}"
    #    ];
  };

}
