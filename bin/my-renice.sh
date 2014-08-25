#!/bin/sh
if [ "$(whoami)" != "root" ]; then
    echo "You don't have sufficient privileges to run this script."
	exit 1
fi

renice -10 -p $(pidof firefox)
renice -10 -p $(pidof Finder)
renice -10 -p $(pidof Evernote)
renice -10 -p $(pidof iTerm)
renice -10 -p $(pidof iTunes)
renice 10 -p $(pidof Dropbox)
renice -10 -p $(pidof GoogleJapaneseInput)
renice -10 -p $(pidof GoogleJapaneseInputRenderer)
renice -10 -p $(pidof GoogleJapaneseInputConverter)
