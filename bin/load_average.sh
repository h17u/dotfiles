#!/bin/sh
# uptime | awk -F\  '{print $(NF - 2),$(NF - 1),$NF}'
uptime | awk -F\  '{print "" $(NF - 1)}' | sed 's/,//g'

# vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker fenc=utf8:
