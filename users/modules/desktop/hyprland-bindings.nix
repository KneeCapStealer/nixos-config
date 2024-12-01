{
  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

  "$mod" = "SUPER";
  "$term" = "kitty";
  "$menu" = "rofi -show drun -show-icons";
  "$browser" = "zen";
  "$fileManager" = "dolphin";

  programShortcuts = [
    "$mod, Q, exec, $term"
    "$mod, E, exec, $fileManager"
    "$mod, SPACE, exec, $menu"
    "$mod, N, exec, $browser"
  ];

  windowManipulation = [
    "$mod, C, killactive,"
    "$mod, M, exit,"
    "$mod, F, togglefloating,"
    "$mod, RETURN, fullscreen,"
    "$mod, P, pseudo, # dwindle"
    "$mod, J, togglesplit, # dwindle"


    # Move focus with mainMod + arrow keys
    "$mod, left, movefocus, l"
    "$mod, right, movefocus, r"
    "$mod, up, movefocus, u"
    "$mod, down, movefocus, d"

    # Move focus with mainMod + vimkeys
    "$mod, H, movefocus, l"
    "$mod, J, movefocus, d"
    "$mod, K, movefocus, u"
    "$mod, L, movefocus, r"
  ];

  workspaceManipulation = [
    # Switch workspaces with mainMod + [0-9]
    "$mod, 1, workspace, 1"
    "$mod, 2, workspace, 2"
    "$mod, 3, workspace, 3"
    "$mod, 4, workspace, 4"
    "$mod, 5, workspace, 5"
    "$mod, 6, workspace, 6"
    "$mod, 7, workspace, 7"
    "$mod, 8, workspace, 8"
    "$mod, 9, workspace, 9"
    "$mod, 0, workspace, 10"

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    "$mod SHIFT, 1, movetoworkspace, 1"
    "$mod SHIFT, 2, movetoworkspace, 2"
    "$mod SHIFT, 3, movetoworkspace, 3"
    "$mod SHIFT, 4, movetoworkspace, 4"
    "$mod SHIFT, 5, movetoworkspace, 5"
    "$mod SHIFT, 6, movetoworkspace, 6"
    "$mod SHIFT, 7, movetoworkspace, 7"
    "$mod SHIFT, 8, movetoworkspace, 8"
    "$mod SHIFT, 9, movetoworkspace, 9"
    "$mod SHIFT, 0, movetoworkspace, 10"

    # Scroll through existing workspaces with mainMod + scroll
    "$mod, mouse_down, workspace, e+1"
    "$mod, mouse_up, workspace, e-1"
    ];

  # Move/resize windows with mainMod + LMB/RMB and dragging
  mouseBindings = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];

  screenshot = [
    ",PRINT, exec, hyprshot --clipboard-only -m active"
    "SHIFT, PRINT, exec, hyprshot --clipboard-only -m region"
  ];

  audioControls = [
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
  ];

  audioControlsRepeat = [
    ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
  ];
}
