#!/usr/bin/env bash
# ./install.sh [--adopt] [--macos] [host]    the equivalent of `darwin-rebuild switch`
#   host     defaults to this Mac's LocalHostName; must match a directory in hosts/
#   --adopt  pull differing files that already exist in $HOME into the repo (review with `git diff`);
#            without it they are moved aside as <name>.pre-stow
#   --macos  also apply darwin/*.sh: system defaults, Touch ID for sudo, file limits (prompts for sudo)
set -euo pipefail

cd -P "$(dirname "$0")"
adopt="" macos=0 host=""
for arg in "$@"; do
  case $arg in
    --adopt) adopt=--adopt ;;
    --macos) macos=1 ;;
    *) host=$arg ;;
  esac
done
host=${host:-$(scutil --get LocalHostName)}
[[ -f hosts/$host/Brewfile ]] || {
  echo "unknown host '$host'; known: $(printf '%s ' hosts/* | sed 's|hosts/||g')" >&2
  exit 1
}

command -v brew >/dev/null || {
  echo "Homebrew is missing: https://brew.sh" >&2
  exit 1
}

# non-official taps live in this repo; Homebrew only clones git URLs, so link the directories
tap_dir="$(brew --repository)/Library/Taps/local"
mkdir -p "$tap_dir"
for tap in darwin/taps/*/; do
  ln -sfn "$PWD/${tap%/}" "$tap_dir/homebrew-$(basename "$tap")"
done

failed=0
brew bundle --file=darwin/Brewfile || failed=1
brew bundle --file="hosts/$host/Brewfile" || failed=1
command -v stow >/dev/null || {
  echo "stow is missing; fix the brew bundle errors above and rerun" >&2
  exit 1
}

# a real file that already exists where stow will link: identical ones go, differing ones move aside
while IFS= read -r file; do
  case $file in
    hosts/*) rel=${file#hosts/*/home/} ;;
    *) rel=${file#*/*/} ;;
  esac
  target="$HOME/$rel"
  [[ -f $target && ! -L $target && ! $target -ef $file ]] || continue
  if cmp -s "$file" "$target"; then
    rm "$target"
  elif [[ -z $adopt ]]; then
    mv "$target" "$target.pre-stow"
    echo "moved $target to $target.pre-stow (differs from the repo; merge by hand or rerun with --adopt)" >&2
  fi
done < <(find home "hosts/$host/home" \( -type f -o -type l \) -not -name .DS_Store)

for pkg in home/*/; do
  stow --no-folding $adopt -d home -t "$HOME" "$(basename "$pkg")"
done
stow --no-folding $adopt -d "hosts/$host" -t "$HOME" home

# macOS only: prints "dark" or "light" each time the appearance changes (needs the Xcode tools)
if [[ $(uname) == Darwin ]] && command -v swiftc >/dev/null; then
  swiftc -O -o "$HOME/.local/bin/theme-monitor" darwin/theme-monitor.swift
fi

bat cache --build
sheldon lock

if ((macos)); then
  darwin/defaults.sh
  darwin/sudo-touchid.sh
  darwin/maxfiles.sh
fi

((! failed)) || {
  echo "brew bundle reported errors above; fix them and rerun ./install.sh" >&2
  exit 1
}
