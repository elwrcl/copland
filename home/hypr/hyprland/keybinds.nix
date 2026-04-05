{ ... }:

let
  ipc = "noctalia-shell ipc call";
in {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bindr = [
      "$mainMod, SUPER_L, exec, ${ipc} launcher toggle"
    ];

    bind = [
      # workspace navigation
      "CTRL $mainMod, right, workspace, r+1"
      "CTRL $mainMod, left,  workspace, r-1"

      # interface
      "$mainMod, Tab,         exec, ${ipc} launcher windows"
      "$mainMod, P,           exec, ${ipc} bar toggle" 
      "CTRL ALT, Delete,      exec, ${ipc} sessionMenu toggle" 
      # plugins
      "$mainMod SHIFT, S,     exec, ${ipc} plugin:screen-shot-and-record screenshot"
      "$mainMod SHIFT, Z,     exec, ${ipc} plugin:screen-shot-and-record search"
      "$mainMod SHIFT, X,     exec, ${ipc} plugin:screen-shot-and-record ocr"
      "$mainMod SHIFT, C,     exec, ${ipc} plugin:music panel"
      # launchers
      "$mainMod, Return,      exec, ghostty"
      "$mainMod, W,           exec, zen-beta"                            
      "$mainMod, E,           exec, nautilus"
      "$mainMod, Z,           exec, code"
      "$mainMod ALT, V,       exec, pavucontrol"                    
      "$mainMod SHIFT, V,     exec, ${ipc} launcher clipboard"      
      "$mainMod SHIFT, L,     exec, ${ipc} lockScreen lock"         
      "CTRL SHIFT, Escape,      exec, ghostty -e btop"                  

      # window management
      "$mainMod, Q,           killactive"
      "$mainMod ALT, SPACE,   togglefloating"
      "$mainMod, F,           fullscreen, 0"
      "$mainMod, D,           fullscreen, 1"
      "$mainMod ALT, P,       pin"

      # focus windows
      "$mainMod, left,        movefocus, l"
      "$mainMod, right,       movefocus, r"
      "$mainMod, up,          movefocus, u"
      "$mainMod, down,        movefocus, d"

      # move windows
      "$mainMod SHIFT, left,  movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"
      "$mainMod SHIFT, up,    movewindow, u"
      "$mainMod SHIFT, down,  movewindow, d"

      # workspace navigation
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # move windows to workspace
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # special workspaces
      "$mainMod, S,       togglespecialworkspace"
      "$mainMod ALT, S,   movetoworkspacesilent, special"

      #  mouse workspace navigation
      "$mainMod, mouse_up,   workspace, +1"
      "$mainMod, mouse_down, workspace, -1"

      # media keys
      "$mainMod SHIFT, N, exec, playerctl next"
      "$mainMod SHIFT, B, exec, playerctl previous"
      "$mainMod SHIFT, P, exec, playerctl play-pause"
    ];

    # mouse binds
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # volume and brightness binds
    bindel = [
      ", XF86AudioRaiseVolume,   exec, ${ipc} volume increase"
      ", XF86AudioLowerVolume,   exec, ${ipc} volume decrease"
      ", XF86MonBrightnessUp,    exec, ${ipc} brightness increase"
      ", XF86MonBrightnessDown,  exec, ${ipc} brightness decrease"
    ];

    # volume and media keys
    bindl = [
      ", XF86AudioMute,    exec, ${ipc} volume muteOutput"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      ", XF86AudioNext,    exec, playerctl next"
      ", XF86AudioPrev,    exec, playerctl previous"
      ", XF86AudioPlay,    exec, playerctl play-pause"
      ", XF86AudioPause,   exec, playerctl play-pause"
    ];
  };
}
