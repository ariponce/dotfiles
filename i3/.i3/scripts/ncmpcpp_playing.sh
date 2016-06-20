artist=$(mpc -f %artist% | head -n 1)
song=$(mpc -f %title% | head -n 1)
state=$(mpc | awk '/\[/ { print $1 }' | tr -d '[]')
mpd_status=$(mpc status)
song_length=$(mpc | awk '/\[/ { print $3 }')
playlist_position=$(mpc | awk '/\[/ { print $2 }' | tr -d '#')


if [ "$state" == "paused" ]
then
    printf '{"full_text": "%s: %s - %s (%s)"}' "$song_length" "$artist" "$song" "$playlist_position";
elif [ "$state" == "playing" ]
then
    printf '{"full_text": "%s: %s - %s (%s)", "color": "#00bc0d"}' "$song_length" "$artist" "$song" "$playlist_position";
else
    printf '{"full_text": "not playing"}'
    fi

