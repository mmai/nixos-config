{ lib, config, ... }: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "alacritty";
    "$menu" = "wofi --show drun";
    "$fileManager" = "dolphin";
    bind =
      [
        "$mod, Q, movetoworkspace, 1"
        "$mod, W, movetoworkspace, 2"
        "$mod, E, movetoworkspace, 3"
        "$mod, R, movetoworkspace, 4"
        "$mod, A, workspace, 1"
        "$mod, S, workspace, 2"
        "$mod, D, workspace, 3"
        "$mod, F, workspace, 4"
        "$mod, space, togglefloating"
        "$mod SHIFT, J, movefocus, d"
        "$mod SHIFT, K, movefocus, u"
        "$mod SHIFT, L, movefocus, r"
        "$mod SHIFT, H, movefocus, l"

        "$mod, T, exec, $terminal"
        "$mod, Y, exec, $fileManager"
        "$mod, M, exec, $menu"
        "$mod, O, fullscreen, 0"
        "ALT, F4, killactive" 
        "$mod ALT, X, exit"
        ", Print, exec, grimblast copy area"
      ];
  };

}
