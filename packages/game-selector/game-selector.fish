#!@fish@

cd $HOME/.local/share/Games

set games
for geafile in */gameexecargs
    set games $games (path dirname $geafile)
end

if test -f $HOME/.cache/lastgame
    set -l lastgame (cat $HOME/.cache/lastgame)
    if set -l idx (contains -i $lastgame $games)
        set -l first $games[1]
        set games[1] $lastgame
        set games[$idx] $first
    end
end

set entries
for game in $games
    set dir (path resolve $game)
    set icon
    for ext in png jpg
        set ti $dir/cover.$ext
        if test -f $ti
            set icon $ti
            break
        end
        set -u ti
    end
    set entries $entries "$game\000icon\x1f$icon"
end

set selected (echo -en (string join '\n' $entries) | @rofi@ -dmenu -show-icons)
if test -n "$selected"
    echo $selected >$HOME/.cache/lastgame
    echo $selected
else
    exit 1
end
