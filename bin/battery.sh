#!/bin/sh
TEMP=/var/tmp/battery
if  [ ! -e $TEMP  ] || [ $(( $(date +%s) - $(date +%s -r $TEMP) )) -gt 10 ]; then
  nice -n 19 pmset -g ps | awk '{ if (NR == 2) print $3 }' | sed 's/;//g' >$TEMP
fi
cat $TEMP

# vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker fenc=utf8:
