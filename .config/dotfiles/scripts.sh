#!/bin/sh

set -eu

readonly STATE_DIR="$HOME/.local/state/dotfiles/hashes/scripts"
mkdir -p "$STATE_DIR"

for script in "$HOME"/.scripts/*.sh; do
  [ -e "$script" ] || continue

  key=$(printf '%s' "$script" | shasum -a 256 | awk '{print $1}')
  state_file="$STATE_DIR/$key"

  current=$({
    cat "$script"
    sed -En 's/^# use: (.*)/\1/p' "$script" | while read -r dep; do
      cat "$dep" 2>/dev/null
    done
  } | shasum -a 256 | awk '{print $1}')
  last=$(cat "$state_file" 2>/dev/null || echo "")

  if [ "$current" != "$last" ]; then
    sh -eu "$script" && echo "$current" >"$state_file"
  fi
done
