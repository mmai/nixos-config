{ pkgs, lib, ... }: {
  programs.waybar = {
    enable = true;
    style = import ./style.nix;
    # systemd = {
    #   enable = true;
    #   target = "hyprland-session.target";
    # };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        # width = 57;
        # spacing = 7;
        modules-left = [
          # "custom/search"
          "keyboard-state"
          "hyprland/workspaces"
          "wlr/taskbar"
          # "custom/lock"
          # "custom/weather"
          # "backlight"
          # "battery"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
        "clock"
        "idle_inhibitor"
        "pulseaudio"
        "tray"
        "network"
        "cpu"
        "memory"
        "custom/power"
        ];

        "keyboard-state" = {
            "numlock" = false;
            "capslock" = true;
            "format" = "{name} {icon}";
            "format-icons" = {
                "locked" = "";
                "unlocked" = "";
            };
        };
        "cpu" = {
            "format" = "{usage}% ";
            "tooltip" = false;
        };
        "memory" = {
            "format" = "{}% ";
        };
        "hyprland/workspaces" = {
          on-click = "activate";
          persistent_workspaces = {
            "*" = 4;
          };
        };

        "wlr/taskbar" = {
          format= "{icon}";
          icon-size= 16;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
        };
        # "custom/search" = {
        #   format = " ";
        #   tooltip = false;
        #   on-click = "${pkgs.tofi}/bin/tofi-drun";
        # };

        # "custom/weather" = {
        #   format = "{}";
        #   tooltip = true;
        #   interval = 3600;
        #   exec = "waybar-wttr";
        #   return-type = "json";
        # };
        # "custom/lock" = {
        #   tooltip = false;
        #   on-click = "sh -c '(sleep 0.5s; hyprlock)' & disown";
        #   format = "";
        # };
        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "  ";
        };
        # clock = {
          # format = ''{:%H : %M}'';
          # tooltip-format = ''
          #   <big>{:%Y %B}</big>
          #   <tt><small>{calendar}</small></tt>'';
        # };
        # backlight = {
        #   format = "{icon}";
        #   format-icons = ["" "" "" "" "" "" "" "" ""];
        # };
        # battery = {
        #   states = {
        #     warning = 30;
        #     critical = 15;
        #   };
        #   format = "{icon}";
        #   format-charging = "{icon}\n󰚥";
        #   tooltip-format = "{timeTo} {capacity}% 󱐋{power}";
        #   format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        # };
        network = {
          # format-wifi = "󰤨";
          # format-ethernet = "󰤨";
          # format-alt = "󰤨";
          # format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = true;
          tooltip-format = "{volume}% {format_source}";
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
          format = " {icon}\n{volume}%";
          format-bluetooth = "󰂯 {icon} {volume}%";
          format-muted = "󰝟 ";
          format-icons = {
            default = ["" "" " "];
          };
        };
      };
    };
  };
}
