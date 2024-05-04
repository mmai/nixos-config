{ self, inputs, pkgs, config, hyprland, ... }: {

  imports = [
    ./keybindings.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./hyprcursor.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # package = hyprland.packages."${pkgs.system}".hyprland;
    # plugins = [];

    settings = {
      env = [
        # "MOZ_WEBRENDER, 1" # for firefox to run on wayland
        # "WLR_RENDERER_ALLOW_SOFTWARE,1"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "intl"; # US, intl., with dead keys
        follow_mouse = 0;
      };

      exec-once = [
        "${pkgs.hypridle}/bin/hypridle"
        "${pkgs.hyprpaper}/bin/hyprpaper"

        (if config.programs.waybar.enable then
          "${pkgs.waybar}/bin/waybar"
        else
          "nwg-panel")
        # "hyprlock" # needed ??
        "alacritty -e tmux new-session -t main"
      ];
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
        rounding = config.theme.rounding;
        drop_shadow = true;
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "rgba(00000055)";
        blur = { enabled = false; };
      };


      misc = {
        # lower the amount of sent frames when nothing is happening on-screen 
        vfr = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = 2;
      };

      animations = {
        enabled = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        # bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        # animation = [
        #     "windows, 1, 7, myBezier"
        #     "windowsOut, 1, 7, default, popin 80%"
        #     "border, 1, 10, default"
        #     "borderangle, 1, 8, default"
        #     "fade, 1, 7, default"
        #     "workspaces, 1, 6, default"
        # ];

        # from nixy
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92 "
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 3.5, easeOutExpo, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
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
  home.packages = builtins.attrValues
    {
      inherit (pkgs)
        wtype# xdotool type for wayland
        wl-clipboard# cli copy / paste (allows to share clipboard with neovim)
        dunst# notifications
        grimblast# screen capture

        #   # Wallpaper daemon
        hyprpaper
        #   swww # vimjoyer recomended
        #   nitrogen

        # logout
        wlogout;
    };
  # } ++ [ inputs.hyprswitch.packages.x86_64-linux.default ];

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk2";
  };

  gtk = {
    enable = true;
    # theme = {
    #   package = pkgs.flat-remix-gtk;
    #   name = "Flat-Remix-GTK-Violet-Darkest-Solid";
    # };
    #
    # iconTheme = {
    #   package = pkgs.flat-remix-icon-theme;
    #   name = "Flat-Remix-Grey-Darkest";
    # };

    font = {
      name = config.theme.font;
      size = 11;
    };
  };

  # home.pointerCursor = {
  #   gtk.enable = true;
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Classic";
  #   size = 14;
  # };
}
