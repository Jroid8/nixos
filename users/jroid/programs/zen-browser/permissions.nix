{
  programs.zen-browser.policies.Permissions =
    builtins.mapAttrs
      (_: Allow: {
        inherit Allow;
        BlockNewRequests = true;
        Locked = true;
      })
      {
        Camera = [ "https://meet.google.com" ];
        Microphone = [
          "https://web.telegram.org"
          "http://localhost:8080"
          "https://meet.google.com"
        ];
        Location = [ ];
        Notifications = [ "https://web.telegram.org" ];
        Autoplay = [ "https://web.telegram.org" ];
        VirtualReality = [ ];
        ScreenShare = [ "https://meet.google.com" ];
      };
}
