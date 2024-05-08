{
  layer = "top";
  "margin-top" = 0;
  "margin-bottom" = 0;
  "margin-left" = 0;
  "margin-right" = 0;
  "spacing" = 0;

  "modules-left" = [
    "hyprland/workspaces"
    "wlr/taskbar"
    "mpris" # show music playing
    # "custom/appmenu"
    # "group/settings"
    # "custom/settings"
    # "group/quicklinks"
    "custom/empty"
  ];

  "modules-center" = [
    "hyprland/window"
  ];

  "modules-right" = [
    "clock"
    # "custom/updates"
    "pulseaudio"
    "bluetooth"
    "battery"
    "network"
    # "group/hardware"
    "disk"
    "cpu"
    "memory"
    # "hyprland/language"
    "custom/cliphist"
    "idle_inhibitor"
    "tray"
    "custom/exit"
    # "custom/ml4w-welcome"
  ];
}
