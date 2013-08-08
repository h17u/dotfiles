#!/bin/sh
# uptime | awk -F\  '{print $(NF - 2),$(NF - 1),$NF}'
uptime | awk -F\  '{print $(NF - 1)}' | sed 's/,//g'
