#!@runtimeShell@
shopt -s nullglob
set -e
export PATH=@path@${PATH:+:$PATH}

other_thumb_fmts="jpeg png bmp webp jpg"
embed_thumb() {
	if [[ $2 == *.jpg ]]; then
		mv "$2" /tmp/cover.jpg
	else
		for ext in $other_thumb_fmts; do
			if [[ "$2" == *.$ext ]]; then
				magick "$2" "/tmp/cover.jpg"
				rm "$2"
				break
			fi
		done
	fi

	if [[ $1 == *.mp4 ]]; then
		python - << EOF
from mutagen import File
video = File(r"$1")
video['covr'] = [open("/tmp/cover.jpg", 'rb').read()]
video.save()
EOF
	elif [[ $1 == *.mkv ]]; then
		mkvpropedit "$1" --attachment-name "cover" --attachment-mime-type "image/jpeg" --add-attachment "/tmp/cover.jpg"
	fi
	rm /tmp/cover.jpg
}

if [[ $1 == all ]]; then
	for vext in mp4 mkv; do
		for vid in *.$vext; do
			unset img
			for iext in jpg $other_thumb_fmts; do
				i="${vid%$vext}$iext"
				if [[ -e "$i" ]]; then
					img="$i"
					break
				fi
			done
			if [[ $img ]]; then
				embed_thumb "$vid" "$img"
			fi
		done
	done
else
	for param in "$@"; do
		if [[ -z $vid ]]; then
			for ext in mp4 mkv; do
				[[ "$param" == *.$ext ]] && vid="$param"
			done
		fi
		if [[ -z $img ]]; then
			for ext in jpg $other_thumb_fmts; do
				[[ "$param" == *.$ext ]] && img="$param"
			done
		fi
	done
	[[ -z $vid || -z $img ]] && exit 1
	embed_thumb "$vid" "$img"
fi
