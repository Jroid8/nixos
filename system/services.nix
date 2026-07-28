{ lib, ... }: {
  services = {
    tuned.enable = true;
    upower.enable = true;
    kanata = {
      enable = true;
      keyboards.default = {
        config = ''
          (defsrc caps a s d f g h j k l scln q w e r t y u i o p)
          (defalias
           caps (tap-hold 100 100 esc (layer-while-held numbers)))
          (deflayer base @caps a s d f g h j k l scln q w e r t y u i o p)
          (deflayer numbers _ 1 2 3 4 5 6 7 8 9 0
           S-1 S-2 S-3 S-4 S-5 S-6 S-7 S-8 S-9 S-0)
        '';
      };
    };
    tor = {
      enable = true;
      client.enable = true;
      settings = {
        HTTPTunnelPort = 9080;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
  systemd.services.tor.wantedBy = lib.mkForce [ ];
}
