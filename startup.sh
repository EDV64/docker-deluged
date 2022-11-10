#!/bin/sh

set -e

if [ "$1" = 'startup' ]; then
	/usr/bin/deluged --config=/config/ --pidfile=/deluged.pid --logfile=/logs/deluged.log --loglevel=info
	/usr/bin/deluge-web --config=/config/ --logfile=/logs/deluge-web.log --loglevel=info
	tail -f /logs/deluged.log
fi
