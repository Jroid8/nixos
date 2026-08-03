{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./userscripts
    ./colors.nix
    ./keybindings.nix
    ./search-engines.nix
  ];

  web-browser = pkgs.qutebrowser;
  programs.qutebrowser = {
    enable = true;
    extraConfig = /* python */ ''
      c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}
    '';
    settings = {
      hints.find_implementation = "javascript";
      qt.chromium.process_model = "process-per-site";
      editor.command = [
        (lib.getExe config.terminal-emulator)
        (lib.getExe config.programs.nvf.settings.vim.build.finalPackage)
        "{file}"
        "+normal {line}G{column0}l"
      ];
      content = {
        dns_prefetch = true;
        geolocation = false;
        canvas_reading = false;
        webgl = false;
        blocking = {
          method = "both";
          adblock.lists = [
            "https://easylist.to/easylist/easylist.txt"
            "https://easylist.to/easylist/easyprivacy.txt"
            "https://raw.githubusercontent.com/SlashArash/adblockfa/master/adblockfa.txt"
            "https://easylist-downloads.adblockplus.org/fanboy-social.txt"
          ];
        };
        javascript.clipboard = "access-paste";
        local_content_can_access_remote_urls = true;
      };
      colors.webpage.darkmode.enabled = true;
    };
  };
}
