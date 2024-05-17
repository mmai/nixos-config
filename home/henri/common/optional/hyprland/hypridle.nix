{ config, pkgs, ... }: {
  config.services.hypridle = {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
        };

        listener = [
          { # Screenlock
            timeout = 900;
            on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
            on-resume = "${pkgs.libnotify}/bin/notify-send 'Welcome back!'";
          }
          { # Suspend
            timeout = 1000;
            on-timeout = "systemctl suspend";
            # on-timeout = "hyprctl dispatch dpms off";
            # on-resume = "hyprctl dispatch dpms on";
            # on-resume = "${pkgs.libnotify}/bin/notify-send 'Welcome back to your desktop!'"
          }
        ];
      };
  };
  # home.packages = with pkgs; [ hypridle ];
  #
  # xdg.configFile."hypr/hypridle.conf".text = ''
  #   general {
  #       ignore_dbus_inhibit = false
  #   }
  #
  #   # Screenlock
  #   listener {
  #       timeout = 900
  #       on-timeout = ${pkgs.hyprlock}/bin/hyprlock
  #       on-resume = ${pkgs.libnotify}/bin/notify-send "Welcome back!"
  #   }
  #
  #   # Suspend
  #   listener {
  #       timeout = 1000
  #       on-timeout = systemctl suspend
  #       # on-resume = ${pkgs.libnotify}/bin/notify-send "Welcome back to your desktop!"
  #   }
  # '';
}
