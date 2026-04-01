{ ... }:

let
  # Noctalia IPC shortcut
  ipc = "noctalia-shell ipc call";
in {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    bindr = [
      "$mainMod, SUPER_L, exec, ${ipc} launcher toggle"
    ];

    bind = [
      # ── Workspace Navigation ─────────────────────────────────────────────
      "CTRL $mainMod, right, workspace, r+1"
      "CTRL $mainMod, left,  workspace, r-1"

      # ── Noctalia Interface ───────────────────────────────────────────────
      "$mainMod, Tab,         exec, ${ipc} launcher windows"        # overview
      "$mainMod, P,           exec, ${ipc} bar toggle"              # hide bar
      "CTRL ALT, Delete,      exec, ${ipc} sessionMenu toggle"      # power menu

      # ── Screenshot / OCR / Google Lens (screen-shot-and-record plugin) ──
      "$mainMod SHIFT, S,     exec, ${ipc} plugin:screen-shot-and-record screenshot"
      "$mainMod SHIFT, Z,     exec, ${ipc} plugin:screen-shot-and-record search"  # google lens
      "$mainMod SHIFT, X,     exec, ${ipc} plugin:screen-shot-and-record ocr"     # ocr
      "$mainMod SHIFT, C,     exec, ${ipc} plugin:music panel"                    # music recognition

      # ── App Launchers ────────────────────────────────────────────────────
      "$mainMod, Return,      exec, kitty"
      "$mainMod, W,           exec, zen"                            
      "$mainMod, E,           exec, dolphin"
      "$mainMod, Z,           exec, zed"
      "$mainMod ALT, V,       exec, pavucontrol"                    
      "$mainMod SHIFT, V,     exec, ${ipc} launcher clipboard"      
      "$mainMod SHIFT, L,     exec, ${ipc} lockScreen lock"         
      "CTRL ALT, Escape,      exec, kitty -e btop"                  

      # ── Window Management ────────────────────────────────────────────────
      "$mainMod, Q,           killactive"
      "$mainMod ALT, SPACE,   togglefloating"
      "$mainMod, F,           fullscreen, 0"
      "$mainMod, D,           fullscreen, 1"
      "$mainMod ALT, P,       pin"

      # ── Focus ────────────────────────────────────────────────────────────
      "$mainMod, left,        movefocus, l"
      "$mainMod, right,       movefocus, r"
      "$mainMod, up,          movefocus, u"
      "$mainMod, down,        movefocus, d"

      # ── Move Windows ─────────────────────────────────────────────────────
      "$mainMod SHIFT, left,  movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"
      "$mainMod SHIFT, up,    movewindow, u"
      "$mainMod SHIFT, down,  movewindow, d"

      # ── Workspaces ───────────────────────────────────────────────────────
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

      # ── Move to Workspace ────────────────────────────────────────────────
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

      # ── Special Workspace (scratchpad) ───────────────────────────────────
      "$mainMod, S,       togglespecialworkspace"
      "$mainMod ALT, S,   movetoworkspacesilent, special"

      # ── Mouse Workspace Scroll ───────────────────────────────────────────
      "$mainMod, mouse_up,   workspace, +1"
      "$mainMod, mouse_down, workspace, -1"

      # ── Media ────────────────────────────────────────────────────────────
      "$mainMod SHIFT, N, exec, playerctl next"
      "$mainMod SHIFT, B, exec, playerctl previous"
      "$mainMod SHIFT, P, exec, playerctl play-pause"
    ];

    # --- Mouse drag / resize ---
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # --- Volume / Brightness (repeat) ---
    bindel = [
      ", XF86AudioRaiseVolume,   exec, ${ipc} volume increase"
      ", XF86AudioLowerVolume,   exec, ${ipc} volume decrease"
      ", XF86MonBrightnessUp,    exec, ${ipc} brightness increase"
      ", XF86MonBrightnessDown,  exec, ${ipc} brightness decrease"
    ];

    # --- Locked binds (media keys / mute) ---
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
