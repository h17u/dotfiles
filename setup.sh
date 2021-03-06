#!/usr/bin/env bash

srcdir="$(pwd)"
destdir="$HOME"

if [[ -d "$srcdir" ]]; then
  echo "Copying dotfiles from $srcdir"
  echo "Symlinking bin executables from $srcdir"
else
  echo "$srcdir does not exist"
  exit 1
fi

copy() {
  from="$1"
  to="$2"
  echo "Copying '$from' to '$to'"
  /bin/rm -rf "$to"
  cp -rp "$from" "$to"
}

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  /bin/rm -rf "$to"
  ln --symbolic --relative --force "$from" "$to"
}

# Copying dotfiles to home
for file in $(find "$srcdir/home" -name '.*' -depth 1); do
  copy "$file" "$destdir/$(basename $file)"
done

# Symlink executables to bin
if [[ ! -d "$destdir/bin" ]]; then
  mkdir -p "$destdir/bin"
fi

for file in $(find "$srcdir/bin" -name '*' -depth 1); do
  link "$file" "$destdir/bin/$(basename $file)"
done

# -*- mode: bash; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim:set et ts=2 sts=2 sw=2 tw=0 fdm=marker:
