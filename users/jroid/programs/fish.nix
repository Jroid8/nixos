{ pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = /* fish */ ''
      ${lib.getExe pkgs.starship} init fish | source
    '';
    shellInit = /* fish */ ''
      function fish_user_key_bindings
      	fish_default_key_bindings -M insert
      	fish_vi_key_bindings --no-erase insert
      	bind -M insert jf -m default backward-char force-repaint
      	bind -M insert ctrl-space forward-char
      end
    '';
    functions = {
      mkcdir = {
        argumentNames = [ "directory name" ];
        description = "make directory and cd to it";
        body = "mkdir $argv[1] && cd $argv[1]";
      };
      y = /* fish */ ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        	builtin cd -- "$cwd"
        end
        command rm -f -- "$tmp"
      '';
      fish_greeting = "";
    };
  };
  home.shell.enableFishIntegration = true;
}
