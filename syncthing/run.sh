#!/bin/bash
set -e

if [ "$HOME" = '/home/user' ]; then
	echo >&2 'uh oh, HOME=/home/user'
	exit 1
fi

mkdir -p "$HOME/.config/syncthing"

set -x
#	-v /etc:/host/etc \
docker run -d \
	--name syncthing \
	--restart always \
	-u "$(id -u):$(id -g)" \
	-v "$HOME:$HOME" \
	-v "$HOME/.config/syncthing:/home/user/.config/syncthing" \
	-v /etc:/etc \
	-v /mnt:/mnt \
	--net host \
	tianon/syncthing "$@"
timeout 10s docker logs -f syncthing || true
