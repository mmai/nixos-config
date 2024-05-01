{ pkgs, ... }:
{

  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland; # default
    # to use if slugishness with portal-hyprland (cf. https://github.com/NixOS/nixpkgs/issues/239886)
    # portalPackage = pkgs.xdg-desktop-portal-gnome;
    xwayland.enable = true;
  };

  # copié de sioodmy :: system/wayland/default.nix
  # environment.etc."greetd/environments".text = ''
  #   Hyprland
  # '';

  environment = {
    variables = {
      # Hints electron apps to use wayland
      NIXOS_OZONE_WL = "1";

      # needed ?
      # SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";

      EGL_PLATFORM = "wayland";
      # wlroots backend/renderer
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";

      # needed ?
      DISABLE_QT_COMPAT = "0";
      DISABLE_QT5_COMPAT = "0";

      MOZ_ENABLE_WAYLAND = "1";
      ANKI_WAYLAND = "1";

      # All the following variables are from 
      # https://wiki.hyprland.org/Configuring/Environment-variables/
      # TODO : check if they are already set by nixos or homemanager packages

      # ---- hyprland env variables ----
      # Enables more verbose logging of wlroots.
      # HYPRLAND_LOG_WLR = "1";
      # Disables realtime priority setting by Hyprland.
      HYPRLAND_NO_RT = "1";
      # If systemd, disables the sd_notify calls.
      HYPRLAND_NO_SD_NOTIFY = "1";

      # ---- Toolkit Backend variables ----
      # Use wayland if available, fall back to x11 if not
      GDK_BACKEND = "wayland,x11";
      # Run SDL2 applications on Wayland.
      # Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
      SDL_VIDEODRIVER = "wayland";
      # Clutter package already has wayland enabled, 
      # this variable will force Clutter applications to try and use the Wayland backend
      CLUTTER_BACKEND = "wayland";

      # ---- XDG Specifications ----
      XDG_SESSION_TYPE = "wayland";
      # XDG_CURRENT_DESKTOP = "Hyprland";
      # XDG_SESSION_DESKTOP = "Hyprland";
      XDG_CACHE_HOME = "/home/henri/.cache";
      XDG_CONFIG_HOME = "/home/henri/.config";

      # ---- QT variables ----
      # (From the Qt documentation) enables automatic scaling, based on the monitor’s pixel density
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      # Disables window decorations on Qt applications
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      # Tell Qt applications to use the Wayland backend, and fall back to x11 if Wayland is unavailable
      QT_QPA_PLATFORM = "wayland;xcb";
      # Tells Qt based applications to pick your theme from qt5ct, use with Kvantum.
      # QT_QPA_PLATFORMTHEME = "qt5ct";

      # ---- NVidia spcifics : see nvidia.nix ----

      # ---- Theming Related Variables ----
      # Set a GTK theme manually, for those who want to avoid appearance tools such as lxappearance or nwg-look
      # GTK_THEME
      # Set your cursor theme. The theme needs to be installed and readable by your user.
      # XCURSOR_THEME
      # Set cursor size
      # XCURSOR_SIZE
    };

    # loginShellInit = ''
    #   dbus-update-activation-environment --systemd DISPLAY
    #   eval $(gnome-keyring-daemon --start --components=ssh,secrets)
    #   eval $(ssh-agent)
    # '';
  };

  hardware = {
    opengl.enable = true;
    pulseaudio.support32Bit = true;
  };

  # copié de sioodmy :: system/wayland/services.nix
  #   systemd.services = {
  # # permet de donner des droits aux programmes ( /dev/dri/card0 pour hyprland..)
  #     seatd = {
  #       enable = true;
  #       description = "Seat management daemon";
  #       script = "${pkgs.seatd}/bin/seatd -g wheel";
  #       serviceConfig = {
  #         Type = "simple";
  #         Restart = "always";
  #         RestartSec = "1";
  #       };
  #       wantedBy = ["multi-user.target"];
  #     };
  #   };

  # services = {
  #   greetd = {
  #     enable = true;
  #     settings = rec {
  #       initial_session = {
  #         command = "Hyprland";
  #         user = "henri";
  #       };
  #       default_session = initial_session;
  #     };
  #   };
  #
  #   gnome = {
  #     glib-networking.enable = true;
  #     gnome-keyring.enable = true;
  #   };
  # };
}
