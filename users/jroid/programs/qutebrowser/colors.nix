{
  programs.qutebrowser = {
    perDomainSettings = {
      "github.com".colors.webpage.darkmode.enabled = false;
    };
    settings = {
      # window.transparent = true;
      # Placeholder
      colors =
        let
          background = "#282c34";
          foreground = "#dfdfdf";

          blue = "#51afef";
          bright-white = "#fefefe";
          cool-gray = "#3b404d";
          cyan = "#46d9ff";
          dark-blue = "#2257a0";
          dark-gray = "#21242b";
          dark-green = "#668044";
          dark-pink = "#945aa6";
          dark-purple = "#615c80";
          darker-purple = "#5b3766";
          gray = "#282c34";
          green = "#98be65";
          light-blue = "#7bb6e2";
          light-gray = "#5b6268";
          lighter-gray = "#73797e";
          medium-gray = "#3f444a";
          pale-gray = "#9ca0a4";
          pink = "#c678dd";
          pure-white = "#ffffff";
          red = "#ff6c6b";
          yellow = "#ecbe7b";
        in
        {
          completion = {
            fg = foreground;
            even.bg = background;
            odd.bg = dark-gray;
            match.fg = pink;
            category = {
              bg = cool-gray;
              fg = blue;
              border = {
                bottom = dark-gray;
                top = dark-gray;
              };
            };
            item.selected = {
              bg = medium-gray;
              fg = foreground;
              match.fg = light-blue;
              border = {
                bottom = medium-gray;
                top = medium-gray;
              };
            };
            scrollbar = {
              bg = background;
              fg = light-gray;
            };
          };
          downloads = {
            bar.bg = dark-gray;
            error = {
              bg = red;
              fg = pure-white;
            };
            start = {
              bg = blue;
              fg = pure-white;
            };
            stop = {
              bg = dark-green;
              fg = pure-white;
            };
            system = {
              bg = "rgb";
              fg = "rgb";
            };
          };
          hints = {
            bg = yellow;
            fg = gray;
          };
          hints.match.fg = dark-green;
          keyhint = {
            bg = dark-gray;
            fg = blue;
            suffix.fg = green;
          };
          messages = {
            error.bg = dark-gray;
            error = {
              border = light-gray;
              fg = red;
            };
            info = {
              bg = background;
              border = light-gray;
              fg = foreground;
            };
            warning = {
              bg = background;
              border = light-gray;
              fg = red;
            };
          };
          prompts = {
            bg = background;
            border = "1px solid " + light-gray;
            fg = foreground;
            selected.bg = light-gray;
          };
          statusbar = {
            caret.bg = dark-purple;
            caret = {
              fg = foreground;
              selection.bg = dark-pink;
              selection.fg = foreground;
            };
            command = {
              bg = background;
              fg = foreground;
              private.bg = background;
              private.fg = foreground;
            };
            insert = {
              bg = dark-blue;
              fg = foreground;
            };
            normal = {
              bg = background;
              fg = foreground;
            };
            passthrough = {
              bg = darker-purple;
              fg = foreground;
            };
            private = {
              bg = light-gray;
              fg = foreground;
            };
            progress.bg = background;
            url = {
              error.fg = red;
              fg = foreground;
              hover.fg = cyan;
              success = {
                http.fg = green;
                https.fg = green;
              };
              warn.fg = yellow;
            };
          };
          tabs = {
            bar.bg = background;
            even = {
              bg = pale-gray;
              fg = bright-white;
            };
            indicator = {
              error = red;
              start = blue;
              stop = green;
              system = "rgb";
            };
            odd = {
              bg = lighter-gray;
              fg = bright-white;
            };
            pinned = {
              even.bg = pale-gray;
              even.fg = bright-white;
              odd = {
                bg = lighter-gray;
                fg = bright-white;
              };
              selected = {
                even.bg = background;
                even.fg = bright-white;
                odd = {
                  bg = background;
                  fg = bright-white;
                };
              };
            };
            selected = {
              even.bg = background;
              even.fg = bright-white;
              odd.bg = background;
              odd.fg = bright-white;
            };
          };
        };
    };
  };
}
