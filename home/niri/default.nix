{ ... }:

{
  xdg.configFile."niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "tr"
            }
            repeat-delay 250
            repeat-rate 35
            numlock-on true
        }

        touchpad {
            natural-scroll
            scroll-factor 0.8
            tap
            dwt
        }

        mouse {
            accel-speed 0.0
            accel-profile "flat"
        }

        focus-follows-mouse
        warp-mouse-to-focus
    }

    # ENV
    environment {
        XDG_CURRENT_DESKTOP  "niri"
        XDG_SESSION_TYPE     "wayland"
        XDG_SESSION_DESKTOP  "niri"
        GDK_BACKEND          "wayland,x11"
        QT_QPA_PLATFORM      "wayland;xcb"
        QT_QPA_PLATFORMTHEME "gtk3"
        QT_STYLE_OVERRIDE    "adwaita-dark"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        TERMINAL             "ghostty"
        MESA_GL_VERSION_OVERRIDE  "4.6"
        MESA_GLSL_VERSION_OVERRIDE "460"
        XCURSOR_THEME        "Bibata-Modern-Classic"
        XCURSOR_SIZE         "24"
    }

    cursor {
        xcursor-theme "Bibata-Modern-Classic"
        xcursor-size 24
    }

    # Autostart
    spawn-at-startup "sh" "-c" "sleep 2 && noctalia-shell"
    spawn-at-startup "gnome-keyring-daemon" "--start" "--components=secrets"
    spawn-at-startup "easyeffects" "--hide-window" "--service-mode"
    spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
    spawn-at-startup "wl-paste" "--type" "image" "--watch" "cliphist" "store"

    layout {
        gaps 8

        border {
            width 1
            active-color   "#33ccffee"
            inactive-color "#31313600"
        }

        focus-ring {
            off
        }

        default-column-width { proportion 0.5; }
    }
    window-rule {
        geometry-corner-radius 18
        clip-to-geometry true
    }
    debug {
        honor-xdg-activation-with-invalid-serial
    }
    window-rule {
        match title=r#"^Open File"#
        open-floating true
    }
    window-rule {
        match title=r#"^Save As"#
        open-floating true
    }
    window-rule {
        match title=r#"^File Upload"#
        open-floating true
    }
    window-rule {
        match app-id=r#"^pavucontrol$"#
        open-floating true
        default-column-width { fixed 900; }
    }
    window-rule {
        match title=r#"[Pp]icture.?[Ii]n.?[Pp]icture"#
        open-floating true
    }
    window-rule {
        match app-id=r#"^steam$"#
        open-floating true
    }
    window-rule {
        match app-id=r#"^steam$"# title=r#"^Steam$"#
        open-floating false
    }
    binds {
        # ── Noctalia IPC ─────────────────────────────────────────────────────────────────────────────────────
        Mod+Space       { spawn-sh "noctalia-shell ipc call launcher toggle"; }
        Mod+Tab         { spawn-sh "noctalia-shell ipc call launcher windows"; }
        Mod+P           { spawn-sh "noctalia-shell ipc call bar toggle"; }
        Ctrl+Alt+Delete { spawn-sh "noctalia-shell ipc call sessionMenu toggle"; }
        Mod+Shift+S     { spawn-sh "noctalia-shell ipc call plugin:screen-shot-and-record screenshot"; }
        Mod+Shift+Z     { spawn-sh "noctalia-shell ipc call plugin:screen-shot-and-record search"; }
        Mod+Shift+X     { spawn-sh "noctalia-shell ipc call plugin:screen-shot-and-record ocr"; }
        Mod+Shift+C     { spawn-sh "noctalia-shell ipc call plugin:music panel"; }
        Mod+Shift+V     { spawn-sh "noctalia-shell ipc call launcher clipboard"; }
        Mod+Shift+L     { spawn-sh "noctalia-shell ipc call lockScreen lock"; }

        # ── Launchers ────────────────────────────────────────────────────────────────────────────────────────
        Mod+Return        { spawn "ghostty"; }
        Mod+W             { spawn "zen-beta"; }
        Mod+E             { spawn "nautilus"; }
        Mod+Z             { spawn "zeditor"; }
        Mod+Alt+V         { spawn "pavucontrol"; }
        Ctrl+Shift+Escape { spawn "ghostty" "-e" "btop"; }

        # ── Window management ────────────────────────────────────────────────
        Mod+Q         { close-window; }
        Mod+F         { fullscreen-window; }
        Mod+D         { maximize-column; }
        Mod+Alt+Space { toggle-window-floating; }

        # ── Focus ────────────────────────────────────────────────────────────
        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up    { focus-window-up; }
        Mod+Down  { focus-window-down; }

        # ── Move windows ─────────────────────────────────────────────────────
        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Down  { move-window-down; }

        # ── Workspaces ───────────────────────────────────────────────────────
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+0 { focus-workspace 10; }

        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }
        Mod+Shift+0 { move-column-to-workspace 10; }

        Ctrl+Mod+Right { focus-workspace-down; }
        Ctrl+Mod+Left  { focus-workspace-up; }

        # Overview
        Mod+S     { toggle-overview; }
        Mod+Alt+S { move-column-to-workspace 1; } // fallback, niri has no silent move

        # ── Media ────────────────────────────────────────────────────────────
        Mod+Shift+N { spawn "playerctl" "next"; }
        Mod+Shift+B { spawn "playerctl" "previous"; }
        Mod+Shift+P { spawn "playerctl" "play-pause"; }

        XF86AudioRaiseVolume  { spawn-sh "noctalia-shell ipc call volume increase"; }
        XF86AudioLowerVolume  { spawn-sh "noctalia-shell ipc call volume decrease"; }
        XF86AudioMute         { spawn-sh "noctalia-shell ipc call volume muteOutput"; }
        XF86AudioMicMute      { spawn "wpctl" "set-mute" "@DEFAULT_SOURCE@" "toggle"; }
        XF86MonBrightnessUp   { spawn-sh "noctalia-shell ipc call brightness increase"; }
        XF86MonBrightnessDown { spawn-sh "noctalia-shell ipc call brightness decrease"; }
        XF86AudioNext         { spawn "playerctl" "next"; }
        XF86AudioPrev         { spawn "playerctl" "previous"; }
        XF86AudioPlay         { spawn "playerctl" "play-pause"; }
        XF86AudioPause        { spawn "playerctl" "play-pause"; }
    }
  '';
}
