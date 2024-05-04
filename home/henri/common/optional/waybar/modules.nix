# nix adaptation of ml4w config by Stephan Raabe (2023) 
# https:#gitlab.com/stephan-raabe/dotfiles/-/tree/main/waybar?ref_type=heads

{
  # Workspaces
  "hyprland/workspaces" = {
    "on-click" = "activate";
    "active-only" = false;
    "all-outputs" = true;
    "format" = "{}";
    "format-icons" = {
      "urgent" = "";
      "active" = "";
      "default" = "";
    };
    "persistent-workspaces" = {
      "*" = 4;
    };
  };
  # Taskbar
  "wlr/taskbar" = {
    "format" = "{icon}";
    "icon-size" = 18;
    "tooltip-format" = "{title}";
    "on-click" = "activate";
    "on-click-middle" = "close";
    "ignore-list" = [
      "Alacritty"
    ];
    "app_ids-mapping" = {
      "firefoxdeveloperedition" = "firefox-developer-edition";
    };
    "rewrite" = {
      "Firefox Web Browser" = "Firefox";
      "Foot Server" = "Terminal";
    };
  };
  # Hyprland Window
  "hyprland/window" = {
    "rewrite" = {
      "(.*) - Brave" = "$1";
      "(.*) - Chromium" = "$1";
      "(.*) - Brave Search" = "$1";
      "(.*) - Outlook" = "$1";
      "(.*) Microsoft Teams" = "$1";
    };
    "separate-outputs" = true;
  };
  # Empty
  "custom/empty" = {
    "format" = "";
  };
  # Youtube Subscriber Count
  "custom/youtube" = {
    "format" = " {}";
    "exec" = "python ~/private/youtube.py";
    "restart-interval" = 600;
    "on-click" = "chromium https:#studio.youtube.com";
    "tooltip" = false;
  };
  # Cliphist
  "custom/cliphist" = {
    "format" = "";
    "on-click" = "sleep 0.1 && ~/dotfiles/scripts/cliphist.sh";
    "on-click-right" = "sleep 0.1 && ~/dotfiles/scripts/cliphist.sh d";
    "on-click-middle" = "sleep 0.1 && ~/dotfiles/scripts/cliphist.sh w";
    "tooltip" = false;
  };
  # Wallpaper
  "custom/wallpaper" = {
    "format" = "";
    "on-click" = "~/dotfiles/hypr/scripts/wallpaper.sh select";
    "on-click-right" = "~/dotfiles/hypr/scripts/wallpaper.sh";
    "tooltip" = false;
  };
  # Waybar Themes
  "custom/waybarthemes" = {
    "format" = "";
    "on-click" = "~/dotfiles/waybar/themeswitcher.sh";
    "tooltip" = false;
  };
  # Settings
  "custom/settings" = {
    "format" = "";
    "on-click" = "~/dotfiles/apps/ML4W_Dotfiles_Settings-x86_64.AppImage";
    "tooltip" = false;
  };
  # Keybindings
  "custom/keybindings" = {
    "format" = "";
    "on-click" = "~/dotfiles/hypr/scripts/keybindings.sh";
    "tooltip" = false;
  };
  # Filemanager Launcher
  "custom/filemanager" = {
    "format" = "";
    "on-click" = "~/dotfiles/.settings/filemanager.sh";
    "tooltip" = false;
  };
  # Outlook Launcher
  "custom/outlook" = {
    "format" = "";
    "on-click" = "chromium --app=https:#outlook.office.com/mail/";
    "tooltip" = false;
  };
  # Teams Launcher
  "custom/teams" = {
    "format" = "";
    "on-click" = "chromium --app=https:#teams.microsoft.com/go";
    "tooltip" = false;
  };
  # Browser Launcher
  "custom/browser" = {
    "format" = "";
    "on-click" = "~/dotfiles/.settings/browser.sh";
    "tooltip" = false;
  };
  # ChatGPT Launcher
  "custom/chatgpt" = {
    "format" = " ";
    "on-click" = "chromium --app=https:#chat.openai.com";
    "tooltip" = false;
  };
  # Calculator
  "custom/calculator" = {
    "format" = "";
    "on-click" = "qalculate-gtk";
    "tooltip" = false;
  };
  # Windows VM
  "custom/windowsvm" = {
    "format" = "";
    "on-click" = "~/dotfiles/scripts/launchvm.sh";
    "tooltip" = false;
  };
  # Rofi Application Launcher
  "custom/appmenu" = {
    # START APPS LABEL
    "format" = "Apps";
    # END APPS LABEL
    "on-click" = "sleep 0.2;rofi -show drun -replace";
    "on-click-right" = "~/dotfiles/hypr/scripts/keybindings.sh";
    "tooltip" = false;
  };
  # Rofi Application Launcher
  "custom/appmenuicon" = {
    "format" = "";
    "on-click" = "rofi -show drun -replace";
    "on-click-right" = "~/dotfiles/hypr/scripts/keybindings.sh";
    "tooltip" = false;
  };
  # Power Menu
  "custom/exit" = {
    "format" = "";
    "on-click" = "wlogout";
    "tooltip" = false;
  };
  # Keyboard State;
  "keyboard-state" = {
    "numlock" = true;
    "capslock" = true;
    "format" = "{name} {icon}";
    "format-icons" = {
      "locked" = "";
      "unlocked" = "";
    };
  };
  # System tray
  "tray" = {
    "icon-size" = 21;
    "spacing" = 10;
  };
  # Clock
  "clock" = {
    "timezone" = "Europe/Paris";
    "locale" = "fr_FR.UTF-8";
    "format" = "{:L%H:%M}";
    "tooltip-format" = "<big>{:L%a %d %B}</big>\n<tt><small>{calendar}</small></tt>";
    "format-alt" = "{:L%a %d %B}";
    "on-click-right" = "gnome-clocks";
    "on-click-middle" = "gnome-calendar";
  };
  # CPU
  "cpu" = {
    "format" = "   {usage}%";
    "on-click" = "alacritty -e htop";
  };
  # Memory
  "memory" = {
    "format" = "   {}%";
    "on-click" = "alacritty -e htop";
  };
  # Harddisc space used
  "disk" = {
    "interval" = 30;
    "format" = " 🖴  {percentage_used}% ";
    "path" = "/";
    "on-click" = "alacritty -e htop";
  };
  "hyprland/language" = {
    "format" = " {short}";
  };
  # Group Hardware;
  # "group/hardware" = {
  #   "orientation" = "inherit";
  #   "drawer" = {
  #     "transition-duration" = 300;
  #     "children-class" = "not-memory";
  #     "transition-left-to-right" = false;
  #   };
  #   "modules" = [
  #     "custom/system"
  #     "disk"
  #     "cpu"
  #     "memory"
  #     "hyprland/language"
  #   ];
  # };
  # Group Settings
  # "group/settings" = {
  #   "orientation" = "horizontal";
  #   "modules" = [
  #     # START CHATGPT TOOGLe
  #     "custom/chatgpt"
  #     # END CHATGPT TOOGLe
  #     "custom/settings"
  #     "custom/waybarthemes"
  #     "custom/wallpaper"
  #   ];
  # };
  # Group Quicklinks
  # "group/quicklinks" = {
  #   "orientation" = "horizontal";
  #   "modules" = [
  #     "custom/browser"
  #     "custom/filemanager"
  #   ];
  # };
  # Network
  "network" = {
    "format" = "{ifname}";
    "format-wifi" = "   {signalStrength}%";
    "format-ethernet" = "  {ifname}";
    "format-disconnected" = "Disconnected";
    "tooltip-format" = " {ifname} via {gwaddri}";
    "tooltip-format-wifi" = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
    "tooltip-format-ethernet" = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
    "tooltip-format-disconnected" = "Disconnected";
    "max-length" = 50;
    "on-click" = "~/dotfiles/.settings/networkmanager.sh";
  };
  # Battery
  "battery" = {
    "states" = {
      # "good" = 95;
      "warning" = 30;
      "critical" = 15;
    };
    "format" = "{icon}   {capacity}%";
    "format-charging" = "  {capacity}%";
    "format-plugged" = "  {capacity}%";
    "format-alt" = "{icon}  {time}";
    # "format-good" = "", // An empty format will hide the module;
    # "format-full" = "";
    "format-icons" = [
      " "
      " "
      " "
      " "
      " "
    ];
  };
  # Pulseaudio
  "pulseaudio" = {
    # "scroll-step" = 1, // %, can be a float
    "format" = "{icon} {volume}%";
    "format-bluetooth" = "{volume}% {icon} {format_source}";
    "format-bluetooth-muted" = " {icon} {format_source}";
    "format-muted" = " {format_source}";
    "format-source" = "{volume}% ";
    "format-source-muted" = "";
    "format-icons" = {
      "headphone" = " ";
      "hands-free" = " ";
      "headset" = " ";
      "phone" = " ";
      "portable" = " ";
      "car" = " ";
      "default" = [
        " "
        " "
        " "
      ];
    };
    "on-click" = "pavucontrol";
  };
  # Bluetooth
  "bluetooth" = {
    "format" = " {status}";
    "format-disabled" = "";
    "format-off" = "";
    "interval" = 30;
    "on-click" = "blueman-manager";
    "format-no-controller" = "";
  };
  # Other
  "user" = {
    "format" = "{user}";
    "interval" = 60;
    "icon" = false;
  };
  # Idle Inhibator
  "idle_inhibitor" = {
    "format" = "{icon}";
    "tooltip" = true;
    "format-icons" = {
      "activated" = "👁️";
      "deactivated" = "";
    };
    "on-click-right" = "hyprlock";
  };
}
