{ lib, config, pkgs, ... }: 
let
  tmux-hypr-nav = pkgs.writeShellApplication {
    name = "tmux-hypr-nav";
    runtimeInputs = builtins.attrValues {
      inherit (pkgs)
        jq;
    };
    text = builtins.readFile ./tmux-hypr-nav.sh;
  };
  in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "alacritty";
    "$menu" = "rofi -show drun -show-icons";
    "$appswitcher" = "rofi -show window -show-icons";
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
        # toggles the split (top/side) of the current window. preserve_split must be enabled for toggling to work
        "$mod, M, togglesplit"
        # swaps the two halves of the split of the current window.
        "$mod, N, swapsplit"

        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, H, movefocus, l"

        # "CTRL, J, exec, ${tmux-hypr-nav} d"
        # "CTRL, K, exec, ${tmux-hypr-nav} u"
        # "CTRL, L, exec, ${tmux-hypr-nav} r"
        # "CTRL, H, exec, ${tmux-hypr-nav} l"
        "CTRL, J, exec, /home/henri/nixos-config/home/henri/common/optional/hyprland/tmux-hypr-nav.sh d"
        "CTRL, K, exec, /home/henri/nixos-config/home/henri/common/optional/hyprland/tmux-hypr-nav.sh u"
        "CTRL, L, exec, /home/henri/nixos-config/home/henri/common/optional/hyprland/tmux-hypr-nav.sh r"
        "CTRL, H, exec, /home/henri/nixos-config/home/henri/common/optional/hyprland/tmux-hypr-nav.sh l"

        "$mod, T, exec, $terminal"
        "$mod, B, exec, $webbrowser"
        "$mod, Y, exec, xdg-open ~"
        "$mod, Z, exec, $menu"
        "$mod, tab, exec, $appswitcher"
        "$mod, O, fullscreen, 0"

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow" # doesn't work ??
        # "$mod, mouse:273, resizewindow"

        "ALT, F4, killactive" 
        "$mod ALT, X, exit" # or wlogout ?

        "$mod, P, exec, grimblast copy area"
      ];

    bindr = [
      "$mod, SUPER_L, exec, pkill rofi || rofi -show combi -show-icons"
    ];

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume & mic on/off
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      # volume + / -
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
    ];
  };

}

# bind flags :
# l -> locked, aka. works also when an input inhibitor (e.g. a lockscreen) is active.
# r -> release, will trigger on release of a key.
# e -> repeat, will repeat when held.
# n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
# m -> mouse, see below
# t -> transparent, cannot be shadowed by other binds.
# i -> ignore mods, will ignore modifiers.
