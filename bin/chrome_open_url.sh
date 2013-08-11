#!/bin/sh
# http://qiita.com/PSP_T/items/d3c0721de71ebbe6461e
line=`cat $1 | wc -l | tr -d ' '`
a=`expr $line + 1`

for (( i=1; i<$a; i++ )); do
url=`sed -n ${i}p $1`;
echo $url;
open -a Google\ Chrome "$url";
done

exit 0

# vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker fenc=utf8:
