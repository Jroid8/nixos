{
  programs.noctalia.settings.bar.default = {
    background_opacity = 0.0;
    capsule = true;
    capsule_fill = "surface";
    capsule_thickness = 0.85;
    margin_edge = 0;
    margin_ends = 0;
    scale = 0.9;
    shadow = false;
    thickness = 28;

    end = [
      "group:usage"
      "tray"
      "notifications"
      "group:system"
      "group:datetime"
    ];
    center = [ "workspaces" ];
    start = [
      "network"
      "bluetooth"
      "media"
    ];

    capsule_group =
      builtins.map
        ({ id, members }: {
          inherit id members;
          fill = "surface";
          opacity = 1.0;
          padding = 8.0;
        })
        [
          {
            id = "datetime";
            members = [
              "date"
              "time"
            ];
          }
          {
            id = "usage";
            members = [
              "cpu"
              "temp"
              "ram"
              "network_rx"
            ];
          }
          {
            id = "system";
            members = [
              "privacy"
              "brightness"
              "volume"
              "battery"
            ];
          }
        ];
  };
}
