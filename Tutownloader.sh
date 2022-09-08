#!/usr/bin/env bash

# Non fonctionnel pour le moment

urlbase="https://fr.tuto.com/compte/achats/video"
Playlist_url="$urlbase/$ID/player"
cookiefile="./cookies.txt"

UA="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0"

ytcmd="$(echo 'yt-dlp --user-agent $UA --cookies ./cookies.txt -o ')"


function get_playlist() {
  curl --user-agent "$UA" -b $cookiefile -sL "$Playlist_url" | grep -E '^var videoPlaylists = ' | sed 's/var videoPlaylists = //' | jq '.[] | "\(.title) \(.sources[].file)"' | sed 's/ http/.%(ext)s" "http/' | head -n -1 | grep "${choice}"
}

function Download_playlist() {
  for videos in get_playlist; do
    yt-dlp --user-agent $UA --cookies $cookiefile -o $videos
  done
  echo "Playlist downloaded !"
}

