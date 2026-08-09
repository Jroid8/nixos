#!@fish@
test -n "$PATH"; and set -x PATH @path@ $PATH; or set -x PATH @path@

if test -z "$argv"
    set game (game-selector)
    test -z "$game" && exit 1
    cd "$HOME/.local/share/Games/$game"
    set -g gamecmd (cat gameexecargs | string split \n)
else
    if test "$argv[1]" = -w
        set -g nowrap
        set argv $argv[2..]
    end
    set -g gamecmd $argv
end

set stopServices ollama mpd mpd-mpris hyprpolkitagent
systemctl stop --user $stopServices

if set -q nowwrap
    $gamecmd
else
    prime-run gamemoderun $gamecmd
end

systemctl start --user $stopServices
