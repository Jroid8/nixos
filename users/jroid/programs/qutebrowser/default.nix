{
  config,
  lib,
  ...
}:
{
  imports = [
    ./scripts
    ./colors.nix
    ./keybindings.nix
    ./search-engines.nix
  ];

  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = true;
    settings = {
      hints.find_implementation = "javascript";
      qt.chromium.process_model = "process-per-site";
      colors.webpage.darkmode.enabled = true;
      editor.command = [
        (lib.getExe config.terminal-emulator)
        (lib.getExe config.programs.nvf.settings.vim.build.finalPackage)
        "{file}"
        "+normal {line}G{column0}l"
      ];
      content = {
        dns_prefetch = true;
        local_content_can_access_remote_urls = true;

        canvas_reading = false;
        geolocation = false;
        javascript.clipboard = "access-paste";
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
      };
    };
  };
}
