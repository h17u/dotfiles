#!/bin/sh
TEMP=/var/tmp/rainbarf
if  [ ! -e $TEMP  ] || [ $(( $(date +%s) - $(date +%s -r $TEMP) )) -gt 10 ]; then
  nice -n 19 rainbarf --width 20 --bolt --rgb >$TEMP
fi
cat $TEMP

# vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker fenc=utf8:
