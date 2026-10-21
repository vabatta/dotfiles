#!/usr/bin/env bash
# ./doctor.sh [host]  reports drift between the repo and this Mac; changes nothing
set -uo pipefail

cd -P "$(dirname "$0")" || exit 1
host=${1:-$(scutil --get LocalHostName)}
bad=0

while IFS= read -r file; do
  rel=${file#*/*/}
  [[ $file == hosts/* ]] && rel=${file#hosts/*/home/}
  target="$HOME/$rel"
  if [[ ! -e $target && ! -L $target ]]; then
    echo "missing   $rel"
    bad=1
  elif [[ ! -L $target ]]; then
    echo "not-link  $rel   (an app replaced the symlink: ./install.sh --adopt pulls it back)"
    bad=1
  elif [[ $(readlink -f "$target") != "$PWD"/* ]]; then
    echo "foreign   $rel -> $(readlink "$target")"
    bad=1
  fi
done < <(find home "hosts/$host/home" \( -type f -o -type l \) -not -name .DS_Store)

all=$(mktemp)
trap 'rm -f "$all"' EXIT
cat darwin/Brewfile "hosts/$host/Brewfile" >"$all"
brew bundle check --file="$all" >/dev/null || { echo "brew      declared software is not installed (brew bundle --file=...)"; bad=1; }
# installed but not declared: add it to a Brewfile or uninstall it
brew bundle cleanup --file="$all" 2>/dev/null | grep -Ev '^(Would|Run)' | sed 's/^/extra     /'

((bad)) || echo "clean"
exit "$bad"
