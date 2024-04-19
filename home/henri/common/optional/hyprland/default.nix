{ pkgs, lib, ... }: {
  # NOTE: xdg portal package is currently set in /hosts/common/optional/hyprland.nix
  
  imports = [
    # custom key binds
    ./keybindings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # plugins = [];

    settings = {
      env = [
        # "MOZ_WEBRENDER, 1" # for firefox to run on wayland
        # "WLR_RENDERER_ALLOW_SOFTWARE,1"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "intl"; # US, intl., with dead keys
        follow_mouse = 1;
      };

      exec-once = ''waybar & hyprpaper & dunst'';
# networkmanagerapplet : nm-applet --indicator &

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

    # See https://wiki.hyprland.org/Configuring/Variables/ for more
        decoration = {
          rounding = 10;

          # blur & drop_shadow are battery hungry
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        # lower the amount of sent frames when nothing is happening on-screen 
        misc = {
          vfr = true;
        };

        animations = {
          enabled = true;

# Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # you probably want this
          no_gaps_when_only = 1;
        };

        master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true;
          no_gaps_when_only = 1;
        };

        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        windowrulev2 = [
          "suppressevent maximize, class:.*" # You'll probably like this.
        ];

    };

    # load at the end of the hyperland set
    # extraConfig = ''    '';
  };

  # # TODO: move below into individual .nix files with their own configs
  home.packages = builtins.attrValues {
    inherit (pkgs)
    dunst # notifications
    grimblast # screen capture

    waybar  # closest thing to polybar available
  #   eww # bar alternative - complex at first but can do cool shit apparently
  #
  #   # Wallpaper daemon
    hyprpaper
  #   swww # vimjoyer recomended
  #   nitrogen

    # lock screen
    hyprlock
   
    # logout
    wlogout

  #   # app launcher
    rofi-wayland;
  };
}
