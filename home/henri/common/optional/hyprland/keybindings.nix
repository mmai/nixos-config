{ lib, config, ... }: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "alacritty";
    "$menu" = "rofi -show drun -show-icons";
    "$fileManager" = "nautilus";
    "$webbrowser" = "firefox";
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
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, H, movefocus, l"

        "$mod, T, exec, $terminal"
        "$mod, B, exec, $webbrowser"
        "$mod, Y, exec, xdg-open ~"
        "$mod, Z, exec, $menu"
        "$mod, O, fullscreen, 0"

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        # "$mod, mouse:273, resizewindow"

        "ALT, F4, killactive" 
        "$mod ALT, X, exit"

        "$mod, P, exec, grimblast copy area"
      ];
  };

}
