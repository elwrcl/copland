{
  config,
  pkgs,
  ...
}:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extest.enable = true;
    protontricks.enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    gamescopeSession = {
      enable = true;
      args = [
        "--fullscreen"
        "--force-grab-cursor"
      ];
    };
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.bash.enable = true;
  hardware.graphics.enable = true;
  hardware.steam-hardware.enable = true;
}
