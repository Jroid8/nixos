#!@runtimeShell@

export PATH=@path@${PATH:+:$PATH}
MPSHOME=$HOME/.local/share/mpd
PL="$MPSHOME/playlists"
MU="$HOME/Music"

gen() {
	mkdir -p "$PL"
	rm $PL/*.m3u
	cd $MU
	all=$(ls)
	while read em; do
		all=$(sed "/$em/d" <<< $all)
	done < $MPSHOME/exclude
	echo "$all" > $PL/ALL.m3u
	for music in *; do
		echo $music >> $PL/$(echo "$music" | cut -d' ' -f1).m3u
	done
	mpc update
}

plsel() {
	pl=$(ls $PL | cut -d . -f 1 | dmenu -no-custom -multi-select)
	[[ -z $pl ]] && exit
	mpc clear
	xargs -I{} mpc load "{}" <<< $pl
	mpc play
}

msel() {
	m=$(ls $MU | dmenu -no-custom -multi-select)
	[[ -z $m ]] && exit
	xargs -I{} mpc insert "{}" <<< $m
	mpc next
	mpc play
}

init() {
	mpc update
	mpc load ALL
	mpc random on
}
$@
