#!/usr/bin/env bash

# from https://github.com/b4b4r07/dotfiles/blob/master/bin/battery
# Vim - ターミナルマルチプレクサ tmux をカスタマイズする - Qiita http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc

#/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | egrep "(\ SSID)" | awk '{print $2" " $3" " $4" " $5" " $6 ;}'

is_mac() { [[ $(echo $OSTYPE | tr '[A-Z]' '[a-z]') =~ 'darwin' ]]; }

function get_ssid()
{
  local ssid=
  if is_mac; then
    airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
    if [ -f "$airport" ]; then
      ssid=$("$airport" -I | egrep "(\ SSID)" | awk '{print $2}')
    fi
  fi

  if [ -z "$ssid" ]; then
    ssid='no_wifi'
    echo "$ssid"
    return 1
  fi
  echo "$ssid"
}

get_ssid

# -*- mode: bash; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:
