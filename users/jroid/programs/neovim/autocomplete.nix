{ lib, ... }: {
  programs.nvf.settings.vim.autocomplete.blink-cmp = {
    enable = true;
    mappings = lib.attrsets.genAttrs [
      "close"
      "confirm"
      "next"
      "previous"
      "scrollDocsDown"
      "scrollDocsUp"
    ] (_: null);
    setupOpts = {
      cmdline.keymap.preset = "inherit";
      completion = {
        documentation.auto_show = false;
      };
      keymap = {
        preset = "none";
        "<A-space>" = [
          "show"
          "show_documentation"
          "hide_documentation"
        ];
        "<A-i>" = [ "select_next" ];
        "<A-o>" = [ "select_prev" ];
        "<A-b>" = [
          "scroll_documentation_up"
          "fallback"
        ];
        "<A-g>" = [
          "scroll_documentation_down"
          "fallback"
        ];
        "<A-n>" = [
          "snippet_forward"
          "fallback"
        ];
        "<A-CR>" = [ "select_and_accept" ];
      };
      appearance = {
        use_nvim_cmp_as_default = true;
      };
      sources.default = [
        "lsp"
        "path"
        "snippets"
      ];
    };
  };
}
