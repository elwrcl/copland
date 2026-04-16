{ ... }:

{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber = {
      enable = true;
      extraConfig."51-no-mic-monitor" = {
        "monitor.alsa.rules" = [
          {
            matches = [ { "node.name" = "~alsa_input.*"; } ];
            actions = {
              "update-props" = {
                "stream.dont-remix" = true;
              };
            };
          }
        ];
      };
    };
    extraConfig.pipewire."92-quantum" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 48000 ];
        "default.clock.quantum" = 512;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 512;
      };
    };
  };
}
