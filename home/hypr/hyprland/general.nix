{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1";

    general = {
      gaps_in = 4;
      gaps_out = 5;
      border_size = 1;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(31313600)";
      resize_on_border = true;
      allow_tearing = true;
      layout = "dwindle";
    };

    dwindle = {
      preserve_split = true;
      smart_split = false;
      smart_resizing = false;
    };

    decoration = {
      rounding = 18;
      rounding_power = 2;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      dim_inactive = true;
      dim_strength = 0.05;
      blur = { enabled = false; };
      shadow = { enabled = false; };
    };

    input = {
      kb_layout = "tr";
      numlock_by_default = true;
      repeat_delay = 250;
      repeat_rate = 35;
      sensitivity = 0.0;
      accel_profile = "flat";
      follow_mouse = 1;
      force_no_accel = true;
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        clickfinger_behavior = true;
        scroll_factor = 0.8;
      };
    };

    gestures = {
      workspace_swipe_distance = 700;
      workspace_swipe_cancel_ratio = 0.2;
      workspace_swipe_min_speed_to_force = 5;
      workspace_swipe_direction_lock = true;
      workspace_swipe_create_new = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      vfr = 1;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      animate_manual_resizes = false;
      focus_on_activate = false;
      no_direct_scanout = false;
    };

    bezier = [
      "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
      "emphasizedDecel, 0.05, 0.7, 0.1, 1"
      "emphasizedAccel, 0.3, 0, 0.8, 0.15"
      "standardDecel, 0, 0, 0, 1"
      "menu_decel, 0.1, 1, 0, 1"
      "menu_accel, 0.52, 0.03, 0.72, 0.08"
      "stall, 1, -0.1, 0.7, 0.85"
    ];

    animation = [
      "windowsIn,  1, 3, emphasizedDecel, popin 80%"
      "windowsOut, 1, 2, emphasizedDecel, popin 90%"
      "windowsMove,1, 3, emphasizedDecel, slide"
      "fadeIn,     1, 3, emphasizedDecel"
      "fadeOut,    1, 2, emphasizedDecel"
      "border,     1, 10, emphasizedDecel"
      "layersIn,   1, 2.7, emphasizedDecel, popin 93%"
      "layersOut,  1, 2.4, menu_accel, popin 94%"
      "fadeLayersIn,  1, 0.5, menu_decel"
      "fadeLayersOut, 1, 2.7, stall"
      "workspaces, 1, 7, menu_decel, slide"
      "specialWorkspaceIn,  1, 2.8, emphasizedDecel, slidevert"
      "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"
    ];
  };
}
