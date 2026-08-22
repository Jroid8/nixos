{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;

      c.format = ''\[[$symbol($version(-$name))]($style)\]'';
      cpp.format = ''\[[$symbol($version(-$name))]($style)\]'';
      cmake.format = ''\[[$symbol($version)]($style)\]'';
      cmd_duration.format = ''\[[⏱ $duration]($style)\]'';
      docker_context.format = ''\[[$symbol$context]($style)\]'';
      dotnet.format = ''\[[$symbol($version)(🎯 $tfm)]($style)\]'';
      git_branch.format = ''\[[$symbol$branch]($style)\]'';
      git_status.format = ''([\[$all_status$ahead_behind\]]($style))'';
      golang.format = ''\[[$symbol($version)]($style)\]'';
      gradle.format = ''\[[$symbol($version)]($style)\]'';
      haskell.format = ''\[[$symbol($version)]($style)\]'';
      java.format = ''\[[$symbol($version)]($style)\]'';
      kotlin.format = ''\[[$symbol($version)]($style)\]'';
      kubernetes.format = ''\[[$symbol$context( \($namespace\))]($style)\]'';
      lua.format = ''\[[$symbol($version)]($style)\]'';
      memory_usage.format = ''\[$symbol[$ram( | $swap)]($style)\]'';
      meson.format = ''\[[$symbol$project]($style)\]'';
      nim.format = ''\[[$symbol($version)]($style)\]'';
      nix_shell.format = ''\[[$symbol$state( \($name\))]($style)\]'';
      nodejs.format = ''\[[$symbol($version)]($style)\]'';
      os.format = ''\[[$symbol]($style)\]'';
      package.format = ''\[[$symbol$version]($style)\]'';
      purescript.format = ''\[[$symbol($version)]($style)\]'';
      python.format = ''\[[''${symbol}''${pyenv_prefix}(''${version})(\($virtualenv\))]($style)\]'';
      rust.format = ''\[[$symbol($version)]($style)\]'';
      time.format = ''\[[$time]($style)\]'';
      username.format = ''\[[$user]($style)\]'';
      zig.format = ''\[[$symbol($version)]($style)\]'';
    };
  };
}
