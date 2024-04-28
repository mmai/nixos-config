{
  layer = "top";
  "margin-top" = 14;
  "margin-bottom" = 0;
  "margin-left" = 0;
  "margin-right" = 0;
  "spacing" = 0;

  "modules-left" = [
    "custom/appmenu"
    # "group/settings"
    "custom/settings"
    "wlr/taskbar"
    # "group/quicklinks"
    "hyprland/window"
    "custom/empty"
  ];

  "modules-center" = [
    "hyprland/workspaces"
  ];

  "modules-right" = [
    "custom/updates"
    "pulseaudio"
    "bluetooth"
    "battery"
    "network"
    # "group/hardware"
    "custom/system"
    "disk"
    "cpu"
    "memory"
    "hyprland/language"
    "custom/cliphist"
    "idle_inhibitor"
    "tray"
    "custom/exit"
    "custom/ml4w-welcome"
    "clock"
  ];
}
